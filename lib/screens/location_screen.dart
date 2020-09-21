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
  var temperature, minTemp, maxTemp, wind, windDirection;
  String cityName;
  String country;
  String weatherIcon;
  String weather;
  String weatherMessage;
  int weatherCondition;
  var dateTime;

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0.0;
        minTemp = 0.0;
        maxTemp = 0.0;
        wind = 0.0;
        windDirection = 'none';
        weatherIcon = '';
        weather = '';
        weatherMessage = 'Unable to get the weather';
        cityName = '';
        country = '';
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

      //converting to utc time for searched location
      dateTime = (DateTime.fromMillisecondsSinceEpoch(
          (weatherData['dt'] - 19800 + weatherData['timezone']) * 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Color scaffoldBackgroundColor =
        dateTime.hour < 6 || dateTime.hour > 15 ? Colors.black : Colors.white;
    Color textColor =
        dateTime.hour < 6 || dateTime.hour > 15 ? Colors.white : Colors.black;

    Color lightTextColor = dateTime.hour < 6 || dateTime.hour > 15
        ? Colors.white54
        : Colors.black54;
    TextStyle cityTextStyle = TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w500,
      fontSize: 26.0,
      color: textColor,
    );
    TextStyle weatherTextStyle = TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w200,
      fontSize: 18.0,
      color: textColor,
    );
    TextStyle tempTextStyle = TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w500,
      fontSize: 26.0,
      color: textColor,
    );
    TextStyle lightTempTextStyle = TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: lightTextColor,
    );
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
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
                          builder: (context) => CityScreen(),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${cityName.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: cityTextStyle,
                    ),
                    Text(
                      '${weather.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: weatherTextStyle,
                    ),
                    Text(
                      '${dateTime.hour} : ${dateTime.minute} UTC',
                      textAlign: TextAlign.center,
                      style: weatherTextStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 45.0),
                      child: Icon(
                          WeatherModel().getWeatherBackAndIcon(
                              weatherCondition, weatherIcon),
                          color: textColor,
                          size: width / 2.5),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
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
                            style: lightTempTextStyle,
                          ),
                          Text(
                            '${temperature.toStringAsFixed(1)}°',
                            style: tempTextStyle,
                          ),
                          Text(
                            ' / ${maxTemp.toStringAsFixed(0)}°',
                            style: lightTempTextStyle,
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
                            style: lightTempTextStyle,
                          ),
                          Text(
                            WeatherModel().windDirection(windDirection),
                            style: lightTempTextStyle,
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
      ),
    );
  }
}
