import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_app/services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    //현재 고정값을 도쿄를 넣은 상태
    //테스트 결과 화면은 출력 됨 그러나
    var weatherData = await WeatherModel().getCityWeather('tokyo');
    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 150,
        ),
      ),
    );
  }
}
