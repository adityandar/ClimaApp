import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.weatherData});

  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temp;
  String cityName;
  String weatherIcon;
  String weatherMessage;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      loading = false;
      if (weatherData == null) {
        return;
      }
      var temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      int weatherId = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(weatherId);
      weatherMessage = weather.getMessage(temp);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          var weatherDataNew =
                              await weather.getLocationWeather();
                          updateUI(weatherDataNew);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          setState(() {
                            loading = true;
                          });
                          print(typedName);

                          if (typedName != null) {
                            var weatherDataNew =
                                await weather.getCityWeather(typedName);
                            updateUI(weatherDataNew);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temp°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      "$weatherMessage in $cityName!",
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: loading,
                child: SpinKitDoubleBounce(
                  color: Colors.white70,
                  size: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
