// import 'networking.dart';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'custom_widgets.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({Key key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'USD';

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getBtcData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Coin Ticker')),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CardWidget(
                      cryptoCurrency: 'BTC',
                      value: isWaiting ? '?' : coinValues['BTC'],
                      selectedCurrency: selectedCurrency,
                    ),
                    CardWidget(
                      cryptoCurrency: 'ETH',
                      value: isWaiting ? '?' : coinValues['ETH'],
                      selectedCurrency: selectedCurrency,
                    ),
                    CardWidget(
                      cryptoCurrency: 'LTC',
                      value: isWaiting ? '?' : coinValues['LTC'],
                      selectedCurrency: selectedCurrency,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: kPrimaryColor,
                  child: Center(
                    child: DropdownButton<String>(
                      style: TextStyle(color: Colors.white),
                      dropdownColor: kPrimaryColor,
                      value: selectedCurrency,
                      items: getDropdownItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value;
                          getData();
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class CardWidget extends StatelessWidget {
  CardWidget({this.value, this.selectedCurrency, this.cryptoCurrency});
  final String value, selectedCurrency, cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          '1 $cryptoCurrency = $value $selectedCurrency',
          style: kTextStyle,
        ),
      ),
      color: kPrimaryColor,
    );
  }
}
