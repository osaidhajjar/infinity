// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:gamification/app_data.dart';
// import 'package:gamification/welcome_screen.dart';
// import 'package:gamification/widgets/color_spot_result_widget.dart';
// import 'package:gamification/widgets/color_spot_widget.dart';

// class LevelTemplate extends StatefulWidget {
//   final List<Color> colorsOptions;
//   final Color correctResultColor;
//   final String title;
//   final String mission;

//   LevelTemplate(
//       {this.title = "",
//       this.mission = "",
//       this.colorsOptions,
//       this.correctResultColor = Colors.black,
//       Key key})
//       : super(key: key);

//   @override
//   _LevelTemplateState createState() => _LevelTemplateState();
// }

// class _LevelTemplateState extends State<LevelTemplate> {
//   List<ColorSpotWidget> _colorsWidgets;
//   ColorSpotResultWidget _resultColorWidget;
//   double _width = 0;

//   void updateMe() {
//     if (_resultColorWidget.resultedColor == widget.correctResultColor) {
//       _width = 100;
//       AppData.currentLevel++;
//       if (AppData.currentLevel < AppData.levels.length) {
//         Timer(Duration(seconds: 2), () {
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                   builder: (context) => AppData.levels[AppData.currentLevel]),
//               (Route<dynamic> route) => false);
//         });
//       } else {
//         //TODO: do something when finish all levels
//       }
//     }
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();

//     _colorsWidgets =
//         widget.colorsOptions.map((color) => ColorSpotWidget(color)).toList();

//     _resultColorWidget =
//         ColorSpotResultWidget(widget.correctResultColor, 2, updateMe);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           leading: GestureDetector(
//               onTap: () => Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => WelcomeScreen()),
//                   (Route<dynamic> route) => false),
//               child: Icon(Icons.home)),
//         ),
//         body: SafeArea(
//             child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Image(
//                 image: AssetImage('assets/bg_level.png'),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             ListView(
//               children: [
//                 SizedBox(height: 50),
//                 Center(
//                     child: Text(widget.mission,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 20))),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: _colorsWidgets
//                         .map((e) => Row(
//                               children: [
//                                 SizedBox(width: 10),
//                                 e.getDraggableWidget(),
//                                 SizedBox(width: 10),
//                               ],
//                             ))
//                         .toList()),
//                 SizedBox(height: 30),
//                 _resultColorWidget.getWidget(),
//                 SizedBox(height: 30),
//                 Center(
//                     child: AnimatedContainer(
//                         width: _width,
//                         height: _width,
//                         duration: Duration(seconds: 1),
//                         child: Image(
//                           image: AssetImage('assets/star.png'),
//                         )))
//               ],
//             ),
//           ],
//         )));
//   }
// }
