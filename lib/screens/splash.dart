import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:weatherama/screens/loading_screen.dart';

class Splash extends StatefulWidget {
  static String id = 'SplashScreen';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        Tween<double>(begin: 100, end: 200).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.reverse(from: 1);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        Future.delayed(Duration(milliseconds: 100), () {
          Navigator.pushReplacementNamed(context, LoadingScreen.id);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Image(
                width: animation.value,
                image: AssetImage('images/hero.png'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TyperAnimatedTextKit(
                text: ['Weatherama'],
                speed: Duration(milliseconds: 100),
                isRepeatingAnimation: false,
                textStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
