import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherData,
      );
    }));

//
//    print('$cityName, $temp, $weatherId');
  }

  @override
  Widget build(BuildContext context) {
    getLocationData();

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white70,
          size: 100.0,
        ),
      ),
    );
  }
}
