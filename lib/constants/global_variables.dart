import 'package:flutter/material.dart';

class GlobalVariables {
  static getLineGradient() {
    return const LinearGradient(colors: [
      Color.fromARGB(255, 221, 217, 217),
      Color.fromARGB(255, 53, 136, 204)
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  }

  static const String imageUrl =
      "https://images.firstpost.com/wp-content/uploads/2017/04/prabhas-baahubali.jpg";
  static const Color backgroundColor = Color.fromARGB(255, 23, 22, 22);
  static const Color appBarColor = Color.fromARGB(255, 50, 48, 48);
  static const Gradient titleGradient = LinearGradient(
      colors: [Colors.white, Color.fromARGB(255, 16, 101, 170)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const Gradient buttonGradient = LinearGradient(colors: [
    Color.fromARGB(255, 5, 104, 117),
    Color.fromARGB(255, 14, 78, 190),
    Color.fromARGB(255, 5, 149, 168)
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
}
