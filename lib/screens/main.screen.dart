import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
   

   final WeatherData weatherData;

   MainScreen ({ @required this.weatherData,});
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  String city;

  void updateDisplayInfo(WeatherData weatherData){
   setState(() {
     temperature = weatherData.currentTemperature.round();
     city = weatherData.city;
    //  WeatherDisplayData weatherDisplayData = weatherData.getWeatherDisplayData();
    //  backgroundImage = weatherDisplayData.weatherImage;
    //  weatherDisplayIcon = weatherDisplayData.weatherIcon;

   });
  }

  @override
  void initState() {
  
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration:  BoxDecoration(
          image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(
              height: 12.0,
            ),
             Center(
              child: Text(
                '$temperature°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
             const SizedBox(
              height: 12.0,
            ),
            Center(
              child: Text(
                'city',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
