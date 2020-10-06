import 'package:clima/services/position.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(cityName) async {
    String urlNew = '$url?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(urlNew);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    double longitude;
    double latitude;

    Position position = Position();
    await position.getLocation();

    longitude = position.getLongitude();
    latitude = position.getLatitude();

    String urlNew =
        '$url?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(urlNew);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 35) {
      return 'It\'s 🍦 time';
    } else if (temp > 26) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
