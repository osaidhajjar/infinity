import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ColorSpotWidget extends StatefulWidget {
  final Color color;
  final _ColorSpotWidgetState localState = _ColorSpotWidgetState();

  ColorSpotWidget({this.color, Key key}) : super(key: key);

  void reset() => localState.draggedToTarget = false;

  @override
  _ColorSpotWidgetState createState() => localState;
}

class _ColorSpotWidgetState extends State<ColorSpotWidget> {
  bool draggedToTarget = false;

  Widget get baseWidget => Image(
      image: AssetImage('assets/spot.png'),
      color: widget.color,
      width: kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70,
      height: kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
            image: AssetImage('assets/floor_target.png'),
            color: widget.color.withAlpha(70),
            width: kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70,
            height: kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70),
        Draggable<Color>(
          data: widget.color,
          childWhenDragging: Container(
              width: kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70,
              height:
                  kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70),
          feedback: baseWidget,
          child: draggedToTarget
              ? Container(
                  width: kIsWeb
                      ? 70 / MediaQuery.of(context).devicePixelRatio
                      : 70,
                  height: kIsWeb
                      ? 70 / MediaQuery.of(context).devicePixelRatio
                      : 70)
              : baseWidget,
          onDragCompleted: () => setState(() => draggedToTarget = true),
        )
      ],
    );
  }
}
