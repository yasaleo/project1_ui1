import 'package:flutter/material.dart';

class MyColors {
  Color fcolor = Colors.grey;

  List<Color> cc1 = [
    const Color.fromARGB(255, 184, 61, 23),
    const Color.fromARGB(255, 205, 237, 181),
    const Color.fromARGB(255, 190, 129, 16),
    const Color.fromARGB(255, 40, 201, 19),
    const Color.fromARGB(255, 255, 193, 7),
    const Color.fromARGB(255, 255, 119, 119),
    const Color.fromARGB(255, 255, 136, 106),
    const Color.fromARGB(255, 255, 108, 71),
    const Color.fromARGB(255, 225, 216, 35),
    const Color.fromARGB(255, 175, 231, 8),
    const Color.fromARGB(255, 90, 233, 19),
    const Color.fromARGB(255, 17, 225, 118),
    const Color.fromARGB(255, 221, 195, 195),
    const Color.fromARGB(255, 23, 223, 163),
    const Color.fromARGB(255, 22, 209, 209),
    const Color.fromARGB(255, 20, 202, 230),
    const Color.fromARGB(255, 86, 137, 249),
    const Color.fromARGB(255, 159, 149, 255),
    const Color.fromARGB(255, 207, 151, 255),
    const Color.fromARGB(255, 239, 151, 255),
    const Color.fromARGB(255, 255, 151, 227),
    const Color.fromARGB(255, 255, 112, 183),
    const Color.fromARGB(255, 255, 112, 141),
    const Color.fromARGB(255, 181, 186, 237),
    const Color.fromARGB(255, 255, 100, 100),
    const Color.fromARGB(255, 227, 181, 237),
  ];

  shufflemycolors() {
    cc1.shuffle();
    fcolor = cc1[0];
  }
}
