import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'brain.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "INR";

  String currencyValueBTC = "?";
  List conversionRatesBTC;

  String currencyValueETH = "?";
  List conversionRatesETH;

  String currencyValueLTC = "?";
  List conversionRatesLTC;

  List<DropdownMenuItem<String>> currencyListBuilder() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (String i in currenciesList) {
      currencyList.add(
        DropdownMenuItem(
          value: i,
          child: Text(i),
        ),
      );
    }
    return currencyList;
  }

  // To get conversion rates as soon as app is opened
  void getValue() async {
    List dataBTC = await getDataBTC();
    List dataETH = await getDataETH();
    List dataLTC = await getDataLTC();
    setState(() {
      conversionRatesBTC = dataBTC;
      conversionRatesETH = dataETH;
      conversionRatesLTC = dataLTC;
      setValue(
          selectedCurrency); //To set the conversion rate  of the default currency (INR)
    });
  }

  void setValue(value) async {
    String selectedCurr = value;
    double valBTC, valETH, valLTC;
    for (int i = 0; i < conversionRatesBTC.length; i++) {
      if (conversionRatesBTC[i]['asset_id_quote'] == selectedCurr) {
        valBTC = await conversionRatesBTC[i]['rate'];
        break;
      }
    }
    for (int i = 0; i < conversionRatesETH.length; i++) {
      if (conversionRatesETH[i]['asset_id_quote'] == selectedCurr) {
        valETH = await conversionRatesETH[i]['rate'];
        break;
      }
    }
    for (int i = 0; i < conversionRatesLTC.length; i++) {
      if (conversionRatesLTC[i]['asset_id_quote'] == selectedCurr) {
        valLTC = await conversionRatesLTC[i]['rate'];
        break;
      }
    }

    setState(() {
      // will update conversion rate on screen when found, Also, as this function already has setState no need of setState inside onChanged
      selectedCurrency = value;
      currencyValueBTC = valBTC.toStringAsFixed(1);
      currencyValueETH = valETH.toStringAsFixed(1);
      currencyValueLTC = valLTC.toStringAsFixed(1);
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 CrpyoTracker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $currencyValueBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $currencyValueETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $currencyValueLTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: currencyListBuilder(),
              onChanged: (value) {
                setValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
