import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatefulWidget {
  final String url;
  const WebViewer({
    super.key,
    required this.url,
  });

  @override
  State<WebViewer> createState() => _StudentIUMSState();
}

class _StudentIUMSState extends State<WebViewer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(sanitizeUrl(widget.url)));
  }

  String sanitizeUrl(String url) {
    if (!url.startsWith('https://') && url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yipee App'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
