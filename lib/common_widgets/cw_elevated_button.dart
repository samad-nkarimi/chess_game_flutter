import 'package:flutter/material.dart';

class CWElevatedButton extends StatelessWidget {
  final Function onPressed;
  final double bRadius;
  final Color primary;
  final Color onPrimary;
  final double hPadding;
  final double vPadding;
  final Widget child;
  const CWElevatedButton({
    Key? key,
    required this.onPressed,
    this.bRadius = 0,
    this.primary = Colors.blue,
    this.onPrimary = Colors.white,
    this.hPadding = 0,
    this.vPadding = 0,
    this.child = const Text(""),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bRadius)),
        primary: primary,
        onPrimary: onPrimary,
      ),
      child: child,
    );
  }
}
