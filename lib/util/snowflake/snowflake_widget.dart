import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants.dart';
import 'snowflake.dart';
import 'snowflake_painter.dart';

class SnowflakeWidget extends StatefulWidget {
  final int numberOfSnowflakes;
  final Color color;

  const SnowflakeWidget({
    required this.numberOfSnowflakes,
    required this.color,
  });

  @override
  State<SnowflakeWidget> createState() => _SnowflakeWidgetState();
}

class _SnowflakeWidgetState extends State<SnowflakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final random = Random();
  late List<Snowflake> snowflakes;

  @override
  void initState() {
    super.initState();

    snowflakes = List.generate(
      widget.numberOfSnowflakes,
      (_) => Snowflake(
        x: random.nextDouble() * 400,
        y: random.nextDouble() * 800,
        radius: random.nextDouble() * 2 + 1,
        speed: random.nextDouble() * 1.5 + 0.5,
      ),
    );

    controller = AnimationController(
      vsync: this,
      duration: NovinarkoConstants.snowflakeDuration,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          for (final snowflake in snowflakes) {
            snowflake.fall(size.height);
          }

          return CustomPaint(
            size: size,
            painter: SnowflakePainter(
              snowflakes: snowflakes,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}
