import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/zip_code.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weather? currentWeather;
  String address = 'ー';
  String? errorMessage;
  List<Weather> hourlyWeather = [
    Weather( temp: 15,description: '晴れ', time: DateTime(2021,10,1,10), rainyPercent: 0),
    Weather( temp: 12,description: '雨', time: DateTime(2021,10,1,11), rainyPercent: 90),
    Weather( temp: 13,description: '曇', time: DateTime(2021,10,1,12), rainyPercent: 30),
    Weather( temp: 19,description: '晴れ', time: DateTime(2021,10,1,13),rainyPercent: 0),
    Weather( temp: 15,description: '晴れ', time: DateTime(2021,10,1,10), rainyPercent: 0),
    Weather( temp: 12,description: '雨', time: DateTime(2021,10,1,11), rainyPercent: 90),
    Weather( temp: 13,description: '曇', time: DateTime(2021,10,1,12), rainyPercent: 30),
    Weather( temp: 19,description: '晴れ', time: DateTime(2021,10,1,13),rainyPercent: 0),
    Weather( temp: 15,description: '晴れ', time: DateTime(2021,10,1,10), rainyPercent: 0),
    Weather( temp: 12,description: '雨', time: DateTime(2021,10,1,11), rainyPercent: 90),
    Weather( temp: 13,description: '曇', time: DateTime(2021,10,1,12), rainyPercent: 30),
    Weather( temp: 19,description: '晴れ', time: DateTime(2021,10,1,13),rainyPercent: 0),
  ];

  List<Weather> dailyWeather = [
    Weather( tempMax: 15, tempMin: 10, time: DateTime(2021,10,2), rainyPercent: 0),
    Weather( tempMax: 19, tempMin: 12, time: DateTime(2021,10,3), rainyPercent: 20),
    Weather( tempMax: 9, tempMin: 1, time: DateTime(2021,10,4), rainyPercent: 0),
    Weather( tempMax: 15, tempMin: 10, time: DateTime(2021,10,2), rainyPercent: 0),
    Weather( tempMax: 19, tempMin: 12, time: DateTime(2021,10,3), rainyPercent: 20),
    Weather( tempMax: 9, tempMin: 1, time: DateTime(2021,10,4), rainyPercent: 0),
    Weather( tempMax: 15, tempMin: 10, time: DateTime(2021,10,2), rainyPercent: 0),
    Weather( tempMax: 19, tempMin: 12, time: DateTime(2021,10,3), rainyPercent: 20),
    Weather( tempMax: 9, tempMin: 1, time: DateTime(2021,10,4), rainyPercent: 0),
  ];

  List<String> weekDay = ['月','火','水','木','金','土','日'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Column(
            children: [
              Container(
                  width: 200,
                  child: TextField(
                    onSubmitted: (value) async{
                      Map<String, String> response = {};
                      response = await ZipCode.searchAddressFromZipCode(value);
                      print(response);
                      errorMessage = response['message'];
                      if(response.containsKey('address')) {
                        address = response['address']!;
                        currentWeather = (await Weather.getCurrentWeather(value))!;
                      }
                      print(address);
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '郵便番号を入力'
                    ),
                  )
              ),
              Text(errorMessage == null ? '' : errorMessage!, style: TextStyle(color: Colors.red),),
              SizedBox(height: 50),
              Text(address, style: TextStyle(fontSize: 25),),
              Text(currentWeather == null ? 'ー' : currentWeather!.description),
              Text(currentWeather == null ? 'ー' :'${currentWeather!.temp}°', style: TextStyle(fontSize: 80),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(currentWeather == null ? 'ー' :'最高: ${currentWeather!.tempMax}°'),
                  ),
                  Text(currentWeather == null ? 'ー' :'最低: ${currentWeather!.tempMin}°'),
                ],
              ),
              SizedBox(height: 50,),
              Divider(height: 0,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: hourlyWeather.map((weather) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text('${DateFormat('H').format(weather.time ?? DateTime.now())}時'),
                          Text('${weather.rainyPercent}%', style: TextStyle(color: Colors.blueAccent)),
                          Icon(Icons.wb_sunny_sharp),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('${weather.temp}°', style: TextStyle(fontSize: 18.0),),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Divider(height: 0,),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: dailyWeather.map((weather) {
                        return Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 50,
                                  child: Text('${weekDay[weather.time!.weekday -1]}曜日')
                              ),
                              Row(
                                children: [
                                  Icon(Icons.wb_sunny_sharp),
                                  Text('${weather.rainyPercent}%', style: TextStyle(color: Colors.blueAccent)),
                                ],
                              ),
                              Container(
                                width: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${weather.tempMax}', style: TextStyle(fontSize: 16),),
                                    Text('${weather.tempMin}', style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.4)),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
