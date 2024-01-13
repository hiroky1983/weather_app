import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  int temp; //　気温
  int tempMax;
  int tempMin;
  String description;
  double lon;
  double lat;
  String icon;
  DateTime? time;
  int rainyPercent;

  Weather({
    this.temp = 0,
    this.tempMax = 0,
    this.tempMin = 0,
    this.description = '',
    this.lon = 0.0,
    this.lat = 0.0,
    this.icon = '',
    this.time,
    this.rainyPercent = 0
  });

  static Future<Weather?> getCurrentWeather(String zipCode) async{
    String _zipCode = '';
    if(_zipCode.contains('-')) {
      _zipCode = zipCode;
    } else {
      _zipCode  = '${zipCode.substring(0, 3)}-${zipCode.substring(3)}';
    }
    String url = 'https://api.openweathermap.org/data/2.5/weather?zip=$_zipCode,JP&appid=1e373375c9ee4a5df9949f0c8242338a&lang=ja&units=metric';
    try {
      var result = await get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(result.body);
      print(data);
      Weather currentWeather = Weather(
        description: data['weather'][0]['description'],
        temp: data['main']['temp'].toInt(),
        tempMax: data['main']['temp_max'].toInt(),
        tempMin: data['main']['temp_min'].toInt()
      );
      return currentWeather;
    } catch(e){
      print(e);
      return null;
    }
  }
}