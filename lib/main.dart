import 'dart:async';
import 'dart:convert';
import 'package:cryptobrasil/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:cryptobrasil/dependency_injection.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cryptobrasil/home_page.dart';
import 'package:cryptobrasil/news_page.dart';
import 'package:cryptobrasil/charts_page.dart';
import 'package:cryptobrasil/compartilhar_page.dart';
import 'package:cryptobrasil/config_page.dart';
import 'package:cryptobrasil/polpriv_page.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/services.dart';
import 'package:cryptobrasil/rate_my_app.dart';



const String testDevices = 'Mobile_id';

RateMyApp _rateMyApp = RateMyApp();

String _dateToString(DateTime date) => date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString();

void main() async {
  Injector.configure(Flavor.PROD);
  runApp(new MyApp());

}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}



class MyAppState extends State<MyApp> {


  
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevices != null ? <String>[testDevices] : null,
      nonPersonalizedAds: true,
      keywords: <String>['Cryptocurrency', 'Bitcoin']);

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('BannrAd $event');
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();       

  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }


  List<Widget> containers = [
    HomePage(),
    NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Brasil',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[100]
              : null),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: new AppBar(
              title: new Text('Crypto Brasil'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: 'Cotação'),
                  Tab(text: 'Notícias'),
                ],
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            body: TabBarView(
              children: containers,
              
            ),
          )),
    );
  }

}

  void choiceAction(String choice) {
    if (choice == Constants.Subscribe) {
      CompartilharPage();
    } else if (choice == Constants.Settings) {
      ConfigPage();
    } else if (choice == Constants.SignOut) {
      PolPrivPage();
    }

    
  }

  





