import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main.screen.dart';
import 'package:weather_app/utils/location.dart';
import 'package:weather_app/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      debugPrint('жайгашкан жери тууралуу маалымат келбейт');

    } 
    
    else {
      debugPrint('latitude:'+ locationData.latitude.toString());
      debugPrint('longitude:'+ locationData.longitude.toString());
      
    }
  }

  void getWeatherData () async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if(weatherData.currentTemperature == null || weatherData.currentCondition == null ){
      debugPrint("Apiден температура же статус маалыматы бош кайтат");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
     return MainScreen(weatherData: weatherData,);
    }));
  }

  @override
  void initState() {
   
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'ТАПШЫРМА-09',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple,
                Colors.blue,
              ]),
        ),
        child: const Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 150,
            duration: Duration(
              milliseconds: 1200,
            ),
          ),
        ),
      ),
    );
  }
}
