import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.webViewData});

  static const id = "/webview";

  final WebViewData webViewData;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.webViewData.uri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.webViewData.title != null
          ? AppBar(
              title: Text(widget.webViewData.title!),
            )
          : null,
      body: WebViewWidget(controller: controller),
    );
  }
}

class WebViewData {
  String? title;
  Uri uri;
  WebViewData({
    this.title,
    required this.uri,
  });
}
