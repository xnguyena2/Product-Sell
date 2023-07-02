import 'package:flutter/material.dart';

const String host = "https://web-production-865f.up.railway.app";

const String hiveSettingBox = 'settings';
const String hiveDefaultAddressID = 'defaultAddress';
const String hiveListAddressID = 'listAddress';

late String deviceID;

const double carouselAspectRatio = 315 / 219;

const Color backgroundColor = Color(0xFFF4F4F4);
const Color secondBackgroundColor = Colors.white;
const Color dartBackgroundColor = Colors.black;
const Color highlightColor = Color(0xFF21c712);
const Color shadowColor = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;
const Color secondTextColor = Color(0xFF8B8B8B);
const Color normalBorderColor = Color(0xFFD8D8DD);
const Color normalBorderColor05 = Color.fromARGB(128, 216, 216, 221);
const Color normalBorderColor08 = Color.fromARGB(190, 255, 255, 255);
const Color highTextColor = Colors.black;
const Color activeColor = Colors.red;
const Color activeColor05 = Color.fromARGB(128, 244, 67, 54);
const Color activeColor08 = Color.fromARGB(205, 244, 67, 54);

String generateID() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
