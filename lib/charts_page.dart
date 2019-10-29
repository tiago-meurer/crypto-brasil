import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class ChartsPage extends StatefulWidget {
  @override 
  _ChartsPageState createState() => new _ChartsPageState();
}


class _ChartsPageState extends State<ChartsPage> {
final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: WebView(
        initialUrl:
            "https://cryptowat.ch/",
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
      ),
    );
  }
}