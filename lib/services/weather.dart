import 'package:weather_icons/weather_icons.dart';
import 'package:weatherama/services/location.dart';
import 'package:weatherama/services/networking.dart';
import 'package:weatherama/utilities/credentials.dart';
import 'package:flutter/material.dart';

const String OWMUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String city) async {
    NetworkHelper networkHelper =
        NetworkHelper('$OWMUrl?q=$city&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$OWMUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  IconData getWeatherBackAndIcon(int weatherCondition, String weatherIcon) {
    if (weatherCondition > 200 && weatherCondition < 211) {
      return WeatherIcons.thunderstorm;
    } else if (weatherCondition < 300) {
      return WeatherIcons.storm_showers;
    } else if (weatherCondition < 400) {
      return WeatherIcons.raindrops;
    } else if (weatherCondition > 499 && weatherCondition < 502) {
      return WeatherIcons.showers;
    } else if (weatherCondition > 501 && weatherCondition < 505) {
      return WeatherIcons.rain;
    } else if (weatherCondition == 511) {
      return WeatherIcons.rain_wind;
    } else if (weatherCondition > 511 && weatherCondition < 600) {
      return WeatherIcons.rain_mix;
    } else if (weatherCondition < 700) {
      return WeatherIcons.snow;
    } else if (weatherCondition == 701) {
      return WeatherIcons.windy;
    } else if (weatherCondition == 711) {
      return WeatherIcons.smoke;
    } else if (weatherCondition == 721 && weatherIcon == '50d') {
      return WeatherIcons.day_haze;
    } else if (weatherCondition == 721 && weatherIcon == '50n') {
      return WeatherIcons.stars;
    } else if (weatherCondition == 731) {
      return WeatherIcons.dust;
    } else if (weatherCondition == 741) {
      return WeatherIcons.fog;
    } else if (weatherCondition == 751) {
      return WeatherIcons.sandstorm;
    } else if (weatherCondition < 800) {
      return WeatherIcons.strong_wind;
    } else if (weatherCondition == 800 && weatherIcon == '01d') {
      return WeatherIcons.day_sunny;
    } else if (weatherCondition == 800 && weatherIcon == '01n') {
      return WeatherIcons.night_clear;
    } else if (weatherCondition == 801) {
      return WeatherIcons.cloud;
    } else if (weatherCondition == 802) {
      return WeatherIcons.cloudy_gusts;
    } else if (weatherCondition == 803) {
      return WeatherIcons.cloudy_windy;
    } else {
      return WeatherIcons.cloudy;
    }
  }

  String windDirection(var direction) {
    if (direction > 270 && direction < 316) {
      return 'NW direction';
    } else if (direction > 315 && direction < 361) {
      return 'N direction';
    } else if (direction > 0 && direction < 46) {
      return 'NE direction';
    } else if (direction > 45 && direction < 91) {
      return 'E direction';
    } else if (direction > 90 && direction < 136) {
      return 'SE direction';
    } else if (direction > 135 && direction < 181) {
      return 'S direction';
    } else if (direction > 180 && direction < 226) {
      return 'SW direction';
    } else if (direction > 226 && direction < 271) {
      return 'W direction';
    } else
      return 'none';
  }
}
