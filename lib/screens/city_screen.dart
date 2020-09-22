import 'package:weatherama/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  CityScreen({this.backgroundColor, this.textColor});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        color: widget.backgroundColor,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Get weather for your location',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: widget.textColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  child: TextField(
                    style: TextStyle(
                      color: widget.backgroundColor,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: widget.textColor,
                      hintText: 'Enter city name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (value) async {
                      var weatherData = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(
                            location: value,
                          ),
                        ),
                      );
                      Navigator.pop(context, weatherData);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage('images/search.png'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
