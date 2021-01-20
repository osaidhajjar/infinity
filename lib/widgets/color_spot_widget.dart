import 'package:flutter/material.dart';

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
      width: 50,
      height: 50);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
            image: AssetImage('assets/floor_target.png'),
            color: widget.color.withAlpha(50),
            width: 50,
            height: 50),
        Draggable<Color>(
          data: widget.color,
          childWhenDragging: Container(width: 50, height: 50),
          feedback: baseWidget,
          child:
              draggedToTarget ? Container(width: 50, height: 50) : baseWidget,
          onDragCompleted: () => setState(() => draggedToTarget = true),
        )
      ],
    );
  }
}
