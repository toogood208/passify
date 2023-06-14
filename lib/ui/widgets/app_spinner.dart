import 'package:flutter/material.dart';

class AppSpinner extends StatelessWidget {
  final Color? color;
  final double? size;
  const AppSpinner({
    Key? key,
    this.color,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(color ?? Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}