import 'dart:convert';
import 'package:http/http.dart';

const String APIkey = "BDF66791-8B5E-4125-9A47-5603C8592782";

const String urlBTC =
    "https://rest.coinapi.io/v1/exchangerate/BTC?apikey=$APIkey";
const String urlETH =
    "https://rest.coinapi.io/v1/exchangerate/ETH?apikey=$APIkey";
const String urlLTC =
    "https://rest.coinapi.io/v1/exchangerate/LTC?apikey=$APIkey";

Future<List> getDataBTC() async {
  Response responseBTC = await get(urlBTC);
  print(responseBTC.statusCode);
  if (responseBTC.statusCode == 200) {
    String dataBTC = responseBTC.body;
    List conversionRatesBTC = jsonDecode(dataBTC)['rates'];
    return conversionRatesBTC;
  } else {
    print("Couldn't fetch data");
    return null;
  }
}

Future<List> getDataETH() async {
  Response responseETH = await get(urlETH);
  print(responseETH.statusCode);
  if (responseETH.statusCode == 200) {
    String dataETH = responseETH.body;
    List conversionRatesETH = jsonDecode(dataETH)['rates'];
    print(conversionRatesETH.length);
    return conversionRatesETH;
  } else {
    print("Couldn't fetch data");
    return null;
  }
}

Future<List> getDataLTC() async {
  Response responseLTC = await get(urlLTC);
  print(responseLTC.statusCode);
  if (responseLTC.statusCode == 200) {
    String dataLTC = responseLTC.body;
    List conversionRatesLTC = jsonDecode(dataLTC)['rates'];
    return conversionRatesLTC;
  } else {
    print("Couldn't fetch data");
    return null;
  }
}
