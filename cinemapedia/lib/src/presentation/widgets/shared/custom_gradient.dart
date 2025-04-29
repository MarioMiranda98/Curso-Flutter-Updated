import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  const CustomGradient({
    super.key,
    required this.stops,
    required this.begin,
    required this.colors,
    required this.end,
  });

  final List<double> stops;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
