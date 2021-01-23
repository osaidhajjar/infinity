import 'package:flutter/material.dart';
import 'package:gamification/levels/finish_screen.dart';
import 'package:gamification/levels/level_01.dart';
import 'package:gamification/levels/level_02.dart';
import 'package:gamification/levels/level_03.dart';
import 'package:gamification/levels/level_04.dart';
import 'package:gamification/levels/level_05.dart';
import 'package:gamification/levels/level_06.dart';
import 'package:gamification/levels/level_07.dart';
import 'package:gamification/levels/level_08.dart';
import 'package:gamification/levels/level_09.dart';
import 'package:gamification/levels/level_10.dart';
import 'package:gamification/levels/level_11.dart';
import 'package:gamification/levels/level_12.dart';
import 'package:gamification/levels/level_13.dart';
import 'package:gamification/levels/level_14.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:gamification/levels/level_15.dart';
import 'package:gamification/levels/level_16.dart';
import 'package:gamification/levels/level_17.dart';
import 'package:gamification/levels/level_18.dart';
import 'package:gamification/levels/level_19.dart';
import 'package:gamification/levels/level_20.dart';
import 'package:gamification/levels/level_21.dart';
import 'package:gamification/levels/level_22.dart';
import 'package:gamification/levels/level_23.dart';
import 'package:gamification/welcome_screen.dart';

class AppData {
  static double getSize(double sz, BuildContext context) =>
      kIsWeb ? sz / MediaQuery.of(context).devicePixelRatio : sz;

  static bool isCompact(BuildContext context) =>
      !kIsWeb ||
      (MediaQuery.of(context).size.width /
              MediaQuery.of(context).devicePixelRatio) <
          500 / MediaQuery.of(context).devicePixelRatio;

  static int currentLevel = 0;

  static Color appBarColor = Color(0xff644CA2);
  static Color bgColor = Color(0xff644CA2).withAlpha(40);

  static List<Widget> getTrophies(BuildContext context) {
    return List<Widget>.generate(
        (AppData.currentLevel / 5).floor(),
        (index) => Padding(
              padding: EdgeInsets.all(AppData.getSize(10, context)),
              child: Image(
                  image: AssetImage(
                      'assets/trophy' + (index + 1).toString() + '.gif')),
            ));
  }

  static Widget getBackgroundWidget(BuildContext context) {
    return Center(
      child: Image(
        height: MediaQuery.of(context).size.height,
        image: AssetImage('assets/bg.gif'),
        fit: BoxFit.fill,
      ),
    );
  }

  static AppBar getAppBar(String title, BuildContext context) {
    return AppBar(
      actions: AppData.getTrophies(context),
      backgroundColor: AppData.appBarColor,
      title: Text(title),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
              (Route<dynamic> route) => false),
          child: Icon(Icons.home)),
    );
  }

  static List<Widget> levels = [
    Level01(),
    Level02(),
    Level03(),
    Level04(),
    Level05(),
    Level06(),
    Level07(),
    Level08(),
    Level09(),
    Level10(),
    Level11(),
    Level12(),
    Level13(),
    Level14(),
    Level15(),
    Level16(),
    Level17(),
    Level18(),
    Level19(),
    Level20(),
    Level21(),
    Level22(),
    Level23(),
    FinishScreen()
  ];
}
