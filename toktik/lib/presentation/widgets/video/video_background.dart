import 'package:flutter/material.dart';

class VideoBackground extends StatelessWidget {
  final List<Color> colors;
  final List<double> stops;

  const VideoBackground({
    super.key,
    this.colors = const [
      Colors.transparent,
      Colors.black,
    ],
    this.stops = const [0.0, 1.0],
  }) : assert(colors.length == stops.length,
            'Stops and Colors must have same length');

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
