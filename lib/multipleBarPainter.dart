import 'package:experiment_paint/backgroundPainter.dart';
import 'package:experiment_paint/singleBarPainter.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MultipleBar extends StatefulWidget {
  final double progressPercentage;
  final List<double> listOfHeights;
  final double width;
  final Color initalColor;
  final Color progressColor;
  final Color backgroundColor;
  final int timeInMilliSeconds;
  final bool isVerticallyAnimated;
  final bool isHorizontallyAnimated;

  MultipleBar({
    this.isVerticallyAnimated = true,
    this.isHorizontallyAnimated = true,
    this.listOfHeights,
    this.initalColor = Colors.red,
    this.progressColor = Colors.green,
    this.backgroundColor = Colors.white,
    @required this.width,
    @required this.progressPercentage,
    this.timeInMilliSeconds = 2000,
  });

  @override
  MultipleBarState createState() {
    return new MultipleBarState();
  }
}

class MultipleBarState extends State<MultipleBar>
    with SingleTickerProviderStateMixin {
  final List<Widget> arrayOfBars = new List();
  Animation<double> horizontalAnimation;
  Animation<double> verticalAnimation;
  AnimationController controller;
  double begin;
  double end;
  @override
  void initState() {
    begin = 0;
    end = widget.width;

    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: widget.timeInMilliSeconds),
        vsync: this);

    horizontalAnimation = Tween(begin: begin, end: end).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    arrayOfBars.add(CustomPaint(
      painter: BackgroundBarPainter(
        widthOfContainer: (widget.isHorizontallyAnimated)
            ? horizontalAnimation.value
            : widget.width,
        heightOfContainer: widget.listOfHeights.reduce(max),
        progresPercentage: widget.progressPercentage,
        initialColor: widget.initalColor,
        progressColor: widget.progressColor,
      ),
    ));

    for (int i = 0; i < widget.listOfHeights.length; i++) {
      verticalAnimation =
          Tween(begin: 0.0, end: widget.listOfHeights[i]).animate(controller)
            ..addListener(() {
              setState(() {});
            });
      controller.forward();
      arrayOfBars.add(
        CustomPaint(
          painter: SingleBarPainter(
              startingPosition:
                  (i * ((widget.width / widget.listOfHeights.length))),
              singleBarWidth: widget.width / widget.listOfHeights.length,
              maxSeekBarHeight: widget.listOfHeights.reduce(max) + 1,
              actualSeekBarHeight: (widget.isVerticallyAnimated)
                  ? verticalAnimation.value
                  : widget.listOfHeights[i],
              heightOfContainer: widget.listOfHeights.reduce(max),
              backgroundColor: widget.backgroundColor),
        ),
      );
    }

    return Center(
      child: Container(
          height: widget.listOfHeights.reduce(max),
          width: widget.width,
          child: Row(
            children: arrayOfBars,
          )),
    );
  }
}
