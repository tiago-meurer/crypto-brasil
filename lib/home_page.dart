import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cryptobrasil/data/crypto_data.dart';
import 'package:cryptobrasil/modules/crypto_presenter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'cotacaotoptabs.dart';
//import 'midia.dart';


class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage> implements CryptoListViewContract {
  CryptoListPresenter _presenter;
  List<Crypto> _currencies;
  bool _isLoading;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _HomePageState() {
    _presenter = new CryptoListPresenter(this);
  }

  @override 
  void initState(){
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
  }


  @override 
  Widget build(BuildContext context){
    return new Scaffold(
      body: _isLoading
          ? new Center(
            child: new CircularProgressIndicator(),
        )
          :new ListView.builder(
            itemCount:_currencies.length,
            itemBuilder: (BuildContext context, int index)=>
               _getRowWithDivider(index),        
        ),
    );
  }


  Widget _getRowWithDivider(int i){
    final Crypto currency = _currencies[i];
    var children = <Widget>[
      new Padding(
        padding: new EdgeInsets.all(10.0),
        child: _getListItemUi(currency)
      ),
      new Divider(height: 5.0),
    ];

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  ListTile _getListItemUi(Crypto currency){
    return new ListTile(
      leading: new FadeInImage(placeholder: new AssetImage('assets/2.0x/money.png'), image: new NetworkImage("http://cryptoicons.co/32@2x/color/"+currency.symbol.toLowerCase()+"@2x.png")),
      title: new Text(currency.name,
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
      _getSubtitleText(currency.priceUsd, currency.percentChange1h),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUSD\n", style: new TextStyle(color: Colors.black));
      String percentageChangeText = "24 horas: $percentageChange%";
      TextSpan percentageChangeTextWidget;

      if(double.parse(percentageChange) > 0 ){
        percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
        style: new TextStyle(color: Colors.green));
      }
      else{
        percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
        style: new TextStyle(color: Colors.red));
      }

      return new RichText(
        text: new TextSpan(
          children: [priceTextWidget, percentageChangeTextWidget]));      
}

@override 
void onLoadCryptoComplete(List<Crypto> items){
  // Implement onLoadCryptoComplete

  setState(() {
    _currencies = items;
    _isLoading = false;
  });
}

@override 
void onLoadCryptoError() {
  // implement onLoadCryptorError
 }
}

