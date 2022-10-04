import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String value = '?';
  CoinData coinData = CoinData();
  List<Widget> screenItems = [];

  @override
  void initState() {
    super.initState();
    getCurrencyExchangeRate();
  }

  void getCurrencyExchangeRate() async {
    screenItems.clear();
    for (String crypto in cryptoList) {
      var exchangeRateData =
          await coinData.getExchangeRates(crypto, selectedCurrency);
      if (exchangeRateData != null) {
        setState(() {
          addCryptos(crypto, exchangeRateData['rate']);
        });
      }
    }
    screenItems.add(Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: Platform.isIOS ? iOSPicker() : androidDropDown(),
    ));
  }

  void addCryptos(String cryptoType, double value) {
    var newItem = Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoType = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    screenItems.add(newItem);
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> currencyList = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      currencyList.add(newItem);
    }

    return DropdownButton<String>(
      items: currencyList,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedCurrency = value;
            getCurrencyExchangeRate();
          });
        }
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getCurrencyExchangeRate();
      },
      backgroundColor: Colors.lightBlue,
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: screenItems,
      ),
    );
  }
}
