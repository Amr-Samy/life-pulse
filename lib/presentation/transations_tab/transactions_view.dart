import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/section_header_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/transaction_list_item_widget.dart';
import 'package:life_pulse/presentation/transations_tab/widgets/wallet_header_widget.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/validation_manager.dart';
import '../widgets/empty_state_place_holder.dart';
import 'controllers/transactions_controller.dart';
import 'controllers/wallet_controller.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionsController transactionsController = Get.put(TransactionsController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        transactionsController.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletController = Get.find<WalletController>(tag: 'WalletController');
    return isGuest()
        ? Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.letsInRoute);
        },
        child: EmptyStateHolder(image: ImageAssets.profile, description: AppStrings.logInHint.tr),
      ),
    )
        : Scaffold(
      backgroundColor: const Color(0xFFF8FDF7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 25,
        title:  Text(
          AppStrings.transactions.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFD7F0E3),
        elevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/background_pattern.png',
          fit: BoxFit.cover,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WalletHeaderWidget(),
            Expanded(
              child: Obx(() {

                if (transactionsController.isLoading.value && transactionsController.transactions.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (transactionsController.transactions.isEmpty) {
                  return RefreshIndicator(
                    color: Colors.green,
                    onRefresh: () async {
                      await Future.wait([
                       walletController.fetchWalletData(),
                      transactionsController.fetchTransactions(isRefresh: true)
                      ]);

                    },
                    child: Stack(
                      children: [
                        ListView(),
                        Center(child: Text(AppStrings.noTransactionsFound.tr)),
                      ],
                    ),
                  );
                }

                final groupedTransactions = transactionsController.groupedTransactions;
                final months = groupedTransactions.keys.toList();

                return RefreshIndicator(
                  color: Colors.green,
                  onRefresh: () async {
                    await Future.wait([
                      walletController.fetchWalletData(),
                      transactionsController.fetchTransactions(isRefresh: true)
                    ]);
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: months.length + (transactionsController.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == months.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final String month = months[index];
                      final transactions = groupedTransactions[month]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeaderWidget(title: month),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: transactions.length,
                            itemBuilder: (context, itemIndex) {
                              return TransactionListItemWidget(transaction: transactions[itemIndex]);
                            },
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}