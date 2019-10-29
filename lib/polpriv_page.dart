import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cryptobrasil/main.dart';

class PolPrivPage extends StatefulWidget {
  @override
  _PolPrivPageState createState() => new _PolPrivPageState();
}

class _PolPrivPageState extends State<PolPrivPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: WebView(
        initialUrl:
            "https://pastebin.com/4s00zYNJ",
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
      ),
    );
  }
}
