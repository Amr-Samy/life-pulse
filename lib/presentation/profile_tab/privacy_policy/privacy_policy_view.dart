import 'package:life_pulse/presentation/resources/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/network/api.dart';
class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            // Inject JS to hide header/footer elements
            await _controller.runJavaScript('''
            // Hide header by tag
            var header = document.querySelector('header');
            if (header) header.style.display = 'none';
          
            // Hide footer by tag
            var footer = document.querySelector('footer');
            if (footer) footer.style.display = 'none';
          
            // Hide breadcrumb navigation
            var breadcrumbs = document.querySelector('.breadcrumb');
            if (breadcrumbs) breadcrumbs.style.display = 'none';
            
             // Disable all link clicks
            document.querySelectorAll('a').forEach(a => {
              a.addEventListener('click', function(e) {
                e.preventDefault();
              });
              a.style.pointerEvents = 'none'; // optional: completely disables interaction
              a.style.color = 'gray'; // visually indicate it's disabled
            });
          ''');

          },
        ),
      )
      ..loadRequest(Uri.parse('https://nabd.kirellos.com/mobile/privacy'));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}


