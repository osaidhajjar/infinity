import 'package:flutter/material.dart';
import 'package:gamification/levels/finish_screen.dart';
import 'package:gamification/levels/level_01.dart';
import 'package:gamification/levels/level_02.dart';
import 'package:gamification/levels/level_03.dart';

class AppData {
  static int currentLevel = 0;

  static List<Widget> levels = [
    Level01(),
    Level02(),
    Level03(),
    FinishScreen()
  ];
}
