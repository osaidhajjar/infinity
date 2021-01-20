// import 'package:flutter/material.dart';
// import 'package:gamification/utils/color_mixer.dart';
// import 'package:gamification/widgets/color_spot_widget.dart';

// class ColorSpotResultWidget {
//   List<ColorSpotWidget> draggedItems = [];
//   Function updateParent;
//   Color correctResultColor;
//   int maxDraggedItems;
//   int draggedItemsCount = 0;

//   ColorSpotResultWidget(
//       this.correctResultColor, this.maxDraggedItems, this.updateParent);

//   Color get resultedColor =>
//       ColorMixer.getMix(draggedItems.map((e) => e.color).toList());

//   void reset() {
//     draggedItems.clear();
//     draggedItemsCount = 0;
//   }

//   Widget getWidget() {
//     List<Widget> widgets = [];
//     if (draggedItemsCount == maxDraggedItems)
//       widgets.add(ColorSpotWidget(resultedColor).getWidget());
//     else
//       for (int i = 0; i < draggedItems.length; i++) {
//         widgets.add(Container(
//             margin: EdgeInsets.only(left: i.toDouble() * 20),
//             child: draggedItems[i].getWidget()));
//       }

//     return DragTarget<ColorSpotWidget>(
//       builder: (_, candidateData, rejectedData) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             Image(
//                 color: resultedColor == correctResultColor
//                     ? correctResultColor.withAlpha(50)
//                     : Colors.grey,
//                 image: AssetImage('assets/floor_target.png'),
//                 width: 100),
//             ...widgets
//           ],
//         );
//       },
//       onWillAccept: (data) {
//         if (draggedItemsCount < maxDraggedItems) {
//           draggedItemsCount++;
//           return true;
//         }
//         return false;
//       },
//       onAccept: (data) {
//         draggedItems.add(data);
//         if (draggedItemsCount == maxDraggedItems &&
//             resultedColor != correctResultColor) reset();
//         updateParent();
//       },
//     );
//   }
// }
