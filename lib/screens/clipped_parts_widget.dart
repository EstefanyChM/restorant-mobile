import 'package:flutter/material.dart';
import 'dart:math';

import 'package:riccos/constants.dart';

class ClippedPartsWidget extends StatelessWidget {
  final Widget top;
  final Widget bottom;
  final double Function(Size, double) splitFunction;

  ClippedPartsWidget({
    required this.top,
    required this.bottom,
    required this.splitFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // I'm putting unmodified top widget to back. I wont cut it.
        // Instead I'll overlay it with clipped bottom widget.
        bottom,
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: FunctionClipper(splitFunction: splitFunction),
            child: top,
          ),
        ),
      ],
    );
  }
}

class FunctionClipper extends CustomClipper<Path> {
  final double Function(Size, double) splitFunction;

  FunctionClipper({required this.splitFunction}) : super();

  Path getClip(Size size) {
    final path = Path();

    // move to split line starting point
    path.moveTo(0, splitFunction(size, 0));

    // draw split line
    for (double x = 1; x <= size.width; x++) {
      path.lineTo(x, splitFunction(size, x));
    }

    // close bottom part of screen
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // I'm returning fixed 'true' value here for simplicity, it's not the part of actual question
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
