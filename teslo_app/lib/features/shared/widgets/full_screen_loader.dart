import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }
}
