import 'package:experiment_paint/multipleBarPainter.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<double> values = [];
  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    for (var i = 0; i < 100; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
    return MaterialApp(
      title: 'Bars',
      theme: ThemeData(
          // primarySwatch: Colors.white,
          ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("bars"),
        ),
        body: Center(
          child: MultipleBar(
            progressPercentage: 0,
            listOfHeights: values,
            width: 400,
            initalColor: Colors.grey,
            progressColor: Colors.red,
            backgroundColor: Colors.white,
            isHorizontallyAnimated: true,
            isVerticallyAnimated: true,
          ),
        ),
      ),
    );
  }
}
