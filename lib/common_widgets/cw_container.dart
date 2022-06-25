import 'package:flutter/material.dart';

class CWContainer extends StatelessWidget {
  final Widget child;
  final double? h;
  final double? w;
  final Color color;
  final Gradient? gradient;
  final Color brColor;
  final BoxShape? shape;
  final BlendMode? blendMode;

  /// topLeft , topRight , bottomRight , bottomLeft
  final List<double> br;
  final double brAll;
  final double brWidth;
  final Alignment? al;
  final List<BoxShadow>? boxShadow;

  /// top , right , bottom , left
  final List<double> mar;

  /// top , right , bottom , left
  final List<double> pad;

  const CWContainer({
    Key? key,
    this.child = const Text(""),
    this.h,
    this.w,
    this.color = Colors.transparent,
    this.gradient,
    this.brColor = Colors.transparent,
    this.blendMode,
    this.br = const [0, 0, 0, 0],
    this.brAll = -1,
    this.brWidth = 1,
    this.al,
    this.boxShadow,
    this.mar = const [0, 0, 0, 0],
    this.pad = const [0, 0, 0, 0],
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> borders = br;
    if (brAll != -1) {
      borders = [brAll, brAll, brAll, brAll];
    }
    return Container(
      height: h,
      width: w,
      alignment: al,
      margin: EdgeInsets.only(
          top: mar[0], right: mar[1], bottom: mar[2], left: mar[3]),
      padding: EdgeInsets.only(
          top: pad[0], right: pad[1], bottom: pad[2], left: pad[3]),
      decoration: BoxDecoration(
        backgroundBlendMode: blendMode,
        color: color,
        gradient: gradient,
        shape: shape ?? BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borders[0]),
          topRight: Radius.circular(borders[1]),
          bottomRight: Radius.circular(borders[2]),
          bottomLeft: Radius.circular(borders[3]),
        ),
        border: Border.all(color: brColor, width: brWidth),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
