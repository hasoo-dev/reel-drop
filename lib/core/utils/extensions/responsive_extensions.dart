import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  double mqHeight(double percentage) => screenHeight * percentage;
  double mqWidth(double percentage) => screenWidth * percentage;
}

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension WidgetExtensions on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget paddingH(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  Widget paddingV(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  Widget h(double? value) => SizedBox(height: value, child: this);
  Widget w(double? value) => SizedBox(width: value, child: this);

  Widget center() => Center(child: this);
  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);
}

extension SpacingExtension on num {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());
}
