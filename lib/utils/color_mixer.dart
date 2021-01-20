import 'package:flutter/material.dart';

class ColorMixer {
  static Color getMix(List<Color> colors) {
    if (colors.length == 2) {
      if (colors.contains(Colors.red) && colors.contains(Colors.blue))
        return Colors.purple;
    }
    return Colors.black;
  }
}
