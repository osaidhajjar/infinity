import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';

class FinishScreen extends StatefulWidget {
  FinishScreen({Key key}) : super(key: key);

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppData.appBarColor,
            title: Center(child: Text("اللامالانهاية"))),
        body: SafeArea(
            child: Stack(
          children: [
            AppData.getBackgroundWidget(context),
            ListView(
              children: [
                SizedBox(height: 30),
                Center(
                    child: Image(
                  image: AssetImage('assets/congrat.png'),
                  width: AppData.getSize(500, context),
                )),
                SizedBox(height: 30),
                GestureDetector(
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                        (Route<dynamic> route) => false),
                    child: Icon(Icons.home, size: 50))
              ],
            ),
          ],
        )));
  }
}
