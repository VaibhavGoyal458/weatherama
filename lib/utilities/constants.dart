import 'package:flutter/material.dart';

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kContentTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontWeight: FontWeight.w500,
  fontSize: 26.0,
);

const kSubContentTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontWeight: FontWeight.w200,
  fontSize: 18.0,
);

const kLightTempTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontWeight: FontWeight.w500,
  fontSize: 16.0,
);

const kSearchTextColor = TextStyle(
  fontFamily: 'Oswald',
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);

const kInputFieldDecoration = InputDecoration(
  filled: true,
  hintText: 'Enter city name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide.none,
  ),
);

const kLocationScreenIconSize = 30.0;
