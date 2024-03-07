import 'package:flutter/material.dart';

class CircularTransitionClipper extends CustomClipper<Path> {
  final double radius;
  final Offset center;

  CircularTransitionClipper({
    required this.radius,
    required this.center,
  });

  @override
  Path getClip(Size size) => Path()
    ..addOval(
      Rect.fromCircle(
        radius: radius,
        center: center,
      ),
    );

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
