import 'package:weather_icons/weather_icons.dart';
import 'package:weatherama/screens/city_screen.dart';
import 'package:weatherama/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:weatherama/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  var temperature, minTemp, maxTemp, wind, windDirection, dateTime;
  String cityName, country, weatherIcon, weather, weatherMessage;
  int weatherCondition;

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = minTemp = maxTemp = wind = 0.0;
        weatherIcon = weather = cityName = country = '';
        windDirection = 'none';
        weatherMessage = 'Unable to get the weather';
        dateTime = 0;
        return;
      }

      weather = weatherData['weather'][0]['main'];
      weatherCondition = weatherData['weather'][0]['id'];
      temperature = weatherData['main']['temp'];
      minTemp = weatherData['main']['temp_min'];
      maxTemp = weatherData['main']['temp_max'];
      wind = weatherData['wind']['speed'];
      windDirection = weatherData['wind']['deg'];
      cityName = weatherData['name'];
      country = weatherData['sys']['country'];
      weatherIcon = weatherData['weather'][0]['icon'];

      //Conversion from Unix UTC to UTC
      dateTime = (DateTime.fromMillisecondsSinceEpoch(
          (weatherData['dt'] - 19800 + weatherData['timezone']) * 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    //Internal custom styles
    double width = MediaQuery.of(context).size.width;
    double containerHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    Color scaffoldBackgroundColor =
        (dateTime.hour < 6 || dateTime.hour > 18) ? Colors.black : Colors.white;
    Color textColor =
        (dateTime.hour < 6 || dateTime.hour > 18) ? Colors.white : Colors.black;

    Color lightTextColor = (dateTime.hour < 6 || dateTime.hour > 18)
        ? Colors.white54
        : Colors.black54;

    //Main Scaffold Widget
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    var weatherData = await weatherModel.getLocationWeather();
                    updateUI(weatherData);
                  },
                  child: Icon(
                    Icons.near_me,
                    color: textColor,
                    size: kLocationScreenIconSize,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    var cityWeatherData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityScreen(
                          backgroundColor: scaffoldBackgroundColor,
                          textColor: textColor,
                        ),
                      ),
                    );

                    if (cityWeatherData != null) {
                      updateUI(cityWeatherData);
                    }
                  },
                  child: Icon(
                    Icons.location_city,
                    color: textColor,
                    size: kLocationScreenIconSize,
                  ),
                ),
              ],
            ),
            Container(
              height: containerHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    '${cityName.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: kContentTextStyle.copyWith(color: textColor),
                  ),
                  Text(
                    '${weather.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: kSubContentTextStyle.copyWith(color: textColor),
                  ),
                  Center(
                    child: Container(
                      height: width / 2,
                      child: Icon(
                          WeatherModel().getWeatherBackAndIcon(
                              weatherCondition, weatherIcon),
                          color: textColor,
                          size: width / 2.5),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          WeatherIcons.thermometer,
                          color: lightTextColor,
                          size: 14,
                        ),
                        Text(
                          ' ${minTemp.toStringAsFixed(0)}° /   ',
                          style: kLightTempTextStyle.copyWith(
                              color: lightTextColor),
                        ),
                        Text(
                          '${temperature.toStringAsFixed(1)}°',
                          style: kContentTextStyle.copyWith(color: textColor),
                        ),
                        Text(
                          ' / ${maxTemp.toStringAsFixed(0)}°',
                          style: kLightTempTextStyle.copyWith(
                              color: lightTextColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          WeatherIcons.strong_wind,
                          color: lightTextColor,
                          size: 14,
                        ),
                        Text(
                          '   ${wind.toStringAsFixed(0)} m/s   ',
                          style: kLightTempTextStyle.copyWith(
                              color: lightTextColor),
                        ),
                        Text(
                          WeatherModel().windDirection(windDirection),
                          style: kLightTempTextStyle.copyWith(
                              color: lightTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
