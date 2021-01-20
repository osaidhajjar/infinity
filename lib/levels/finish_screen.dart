import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
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
        appBar: AppBar(title: Center(child: Text("اللامالانهاية"))),
        body: SafeArea(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            ListView(
              children: [
                SizedBox(height: 30),
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      width: 200,
                      height: 70,
                      child: Center(
                        child: Text(
                          'مبروك',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      )),
                ),
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
