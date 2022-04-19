import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';


const apiKey = 'b0d7173b2dadb20e9c6e19c27207c763';

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({@required this.weatherIcon, this.weatherImage});
}

class WeatherData {
  WeatherData({@required this.locationData});

  LocationHelper locationData;
  double currentTemperature;
  int currentCondition;
  String city;

  Future<void> getCurrentTemperature() async {
    Response response = await get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&unit=metric"),
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {
        debugPrint(e);
      }
    } else {
      debugPrint("Api эч кандай мааниге ээ эмес");
    }
  } 
    WeatherDisplayData getWeatherDisplayData(){
      if (currentCondition <600) {
        return WeatherDisplayData(
            weatherIcon: const Icon(
              FontAwesomeIcons.cloud,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: const AssetImage('assets/images/pasmurno.jpg'));
      } else {
        var now =  DateTime.now();
        if (now.hour >=19){
          return WeatherDisplayData(
              weatherIcon: const Icon(
                FontAwesomeIcons.moon,
                size: 75.0,
                color: Colors.white,
              ),
              weatherImage: const  AssetImage('assets/images/noch.jpg'));
        } else {
           return WeatherDisplayData(
              weatherIcon: const Icon(
                FontAwesomeIcons.sun,
                size: 75.0,
                color: Colors.white,
              ),
              weatherImage:const AssetImage('assets/images/solnecho.jpg'));

        }
      }
    }
  }

  

