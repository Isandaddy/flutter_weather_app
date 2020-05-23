import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double tem;
  String weatherIcon;
  String city;
  String message;

  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(Map<String, dynamic> weatherDataFuture) async {
    final weatherData = await weatherDataFuture;
    setState(() {
      if (weatherData == null) {
        tem = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        city = '';
        return;
      }
      tem = weatherData['main']['temp'];
      int condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(tem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    'https://images.pexels.com/photos/3617500/pexels-photo-3617500.jpeg?cs=srgb&dl=pexels-3617500.jpg&fm=jpg'),
                fit: BoxFit.cover)),
        // 최대값 설정 BoxConstraints
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      //geolocator api에서 현재 위치로 접근시
                      //PlatformException(ERROR_ALREADY_REQUESTING_PERMISSION, A request for permissions is already running, please wait for it to finish before doing another request., null)
                      //발생
                      var weather = weatherModel.getLocationWeather();
                      //updateUI(weather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(tem.toString() + '°'),
                    Text('$weatherIcon'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $city",
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
