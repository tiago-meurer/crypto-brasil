import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: WebView(
        initialUrl:
            "https://br.investing.com/news/cryptocurrency-news",
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
      ),
    );
  }
}
