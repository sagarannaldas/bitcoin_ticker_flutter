import 'package:bitcoin_ticker_flutter/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=DA3F08CC-15EA-45FC-9BFA-BE2A7594C7F5

const apiKey = 'DA3F08CC-15EA-45FC-9BFA-BE2A7594C7F5';
const coinURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getExchangeRates(String cryptoType, String currency) async {
    NetworkHelper networkHelper =
        NetworkHelper('$coinURL/$cryptoType/$currency?apikey=$apiKey');

    var networkData = await networkHelper.getData();
    return networkData;
  }
}
