import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = '5E59D3FF-3E4B-4175-BCD4-00D0E8A67C1C';
const coinWebsite = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getBtcData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinWebsite/$crypto/$selectedCurrency?apikey=$apikey';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double decodedData = data['rate'];
        cryptoPrices[crypto] = decodedData.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get Request';
      }
      
    }
    return cryptoPrices;
  }
}

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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];
