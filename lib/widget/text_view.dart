import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final double textSize;
  final String text;
  final bool translatable;
  final TextStyle textStyle;
  final bool alignCenter;

  TextLabel.withConfig(
      {key,
      @required this.text,
      this.textSize,
      this.translatable,
      this.alignCenter,
      @required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
//      translatable != null && !translatable ? text : text.i18n,
      style: textStyle,
      textAlign: alignCenter != null && alignCenter
          ? TextAlign.center
          : TextAlign.start,
      overflow: TextOverflow.visible,
    );
  }
}
