import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherama/screens/city_screen.dart';
import 'package:weatherama/screens/loading_screen.dart';
import 'package:weatherama/screens/location_screen.dart';
import 'package:weatherama/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Weatherama',
      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => Splash(),
        LocationScreen.id: (context) => LocationScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        CityScreen.id: (context) => CityScreen()
      },
    );
  }
}
