import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '9b40b9ecb9005f6efc5dbdbda64df340';
const openWatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    var weatherData = await NetworkingHelper(url: url).getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    String apiUrl =
        '$openWatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    var weatherData = await NetworkingHelper(url: apiUrl).getData();
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

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
