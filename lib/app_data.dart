import 'package:flutter/material.dart';
import 'package:gamification/levels/finish_screen.dart';
import 'package:gamification/levels/level_01.dart';

class AppData {
  static int currentLevel = 0;

  static List<Widget> levels = [
    Level01(),
    FinishScreen()
    // LevelTemplate(
    //   title: "المستوى الأول",
    //   mission: 'أصنع لون بنفسجي باستخدام لونين',
    //   colorsOptions: [Colors.red, Colors.green, Colors.blue],
    //   correctResultColor: Colors.purple,
    // ),
  ];
}
