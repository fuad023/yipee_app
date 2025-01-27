import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StudentIUMS extends StatefulWidget {
  const StudentIUMS({super.key});

  @override
  State<StudentIUMS> createState() => _StudentIUMSState();
}

class _StudentIUMSState extends State<StudentIUMS> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(sanitizeUrl('https://iums.aust.edu/ums-web/login/')));
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
        backgroundColor: Colors.greenAccent,
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