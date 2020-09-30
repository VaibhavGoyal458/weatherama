import 'package:weatherama/screens/location_screen.dart';
import 'package:weatherama/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  static String id = 'LoadingScreen';
  final String location;
  LoadingScreen({this.location});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    var weatherData;

    if (widget.location == null) {
      weatherData = await WeatherModel().getLocationWeather();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            locationWeather: weatherData,
          ),
        ),
      );
    } else {
      weatherData = await WeatherModel().getCityWeather(widget.location);
      Navigator.pop(context, weatherData);
    }
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
