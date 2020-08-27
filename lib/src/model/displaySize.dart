import 'package:flutter/material.dart';
import 'package:ecommerce/src/helpers/colors_constant.dart';

class ClothingPickingList {
  // TODO: Laptop size
  static const List<String> LapSize = [
    '17.3\"',
    '15.6\"',
    '14\"',
    '13.3\"',
    '12\"',
  ];

  //TODO: Phone size
  static const List<String> PhoneSize = [
    '4.7\"',
    '5\"',
    '5.2\"',
    '5.5\"',
    '6.3\"',
  ];

//TODO: Tablet size
  static const List<String> TabSize = [
    '7\"',
    '7.6\"',
    '8.2\"',
    '9\"',
  ];

  //TODO: list color
  static const List<String> ColorList = [
    'Black',
    'White',
    'Grey',
  ];

//TODO: Convert ColorList value to Color
  Color getColorFromColorList(String value) {
    switch (value) {
      case 'Black':
        return kColorBlack;
      case 'White':
        return kColorWhite;
      case 'Grey':
        return kColorGrey;
      default:
        return kColorWhite;
    }
  }

}
