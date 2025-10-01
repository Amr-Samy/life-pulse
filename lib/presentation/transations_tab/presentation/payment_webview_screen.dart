//
// File: payment_webview_screen.dart
//
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../resources/index.dart';
import '../controllers/transactions_controller.dart';
import '../controllers/wallet_controller.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  int _loadingPercentage = 0;
  bool _isPopping = false;
  Future<void> _handlePop() async {
    if (_isPopping) return;
    setState(() {
      _isPopping = true;
    });
    print("Back gesture intercepted. Refreshing data...");
    try {
      await Future.wait([
        Get.find<TransactionsController>().fetchTransactions(isRefresh: true),
        Get.find<WalletController>(tag: "WalletController").fetchWalletData(),
      ]);
    } catch (e) {
      print("An error occurred while fetching data: $e");
    }
    if (mounted) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            debugPrint('Page finished loading*****************************************: $url');

            setState(() {
              _loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading======================================: $url');
            if(url == "https://nabd.kirellos.com/login"){
              Get.back();
              Get.back();
              await Future.wait([
                Get.find<TransactionsController>().fetchTransactions(isRefresh: true),
                Get.find<WalletController>(tag: "WalletController").fetchWalletData(),
              ]);
              showSuccessSnackBar(message:"تم الدفع بنجاح");
            }
            setState(() {
              _loadingPercentage = 100;
            });
            ///TODO show state snack bar
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        _handlePop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.payment.tr),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loadingPercentage < 100)
              LinearProgressIndicator(
                value: _loadingPercentage / 100.0,
              ),
          ],
        ),
      ),
    );
  }
}