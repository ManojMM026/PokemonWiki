import 'package:flutter/material.dart';
import 'package:mypokedex/widget/text_view.dart';

Widget headline1(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.headline1.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.headline1.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget headline2(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.headline2.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.headline2.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget headline3(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.headline3.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.headline3.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget headline4(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.headline4.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.headline2.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget headline5(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.headline5.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.headline5.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget headline6(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.headline6.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.headline6.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget subtitle1(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.subtitle1.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.subtitle1.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget subtitle2(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.subtitle2.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.subtitle2.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget bodyText2(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.bodyText2.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.bodyText2.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}

Widget caption(BuildContext context, String text,
    {bool translateAble,
    Color color,
    bool alignCenter = false,
    bool underLine = false}) {
  return TextLabel.withConfig(
      text: text,
      alignCenter: alignCenter,
      translatable: translateAble,
      textStyle: color != null
          ? Theme.of(context).textTheme.caption.merge(TextStyle(
              color: color,
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none))
          : Theme.of(context).textTheme.caption.merge(TextStyle(
              decoration:
                  underLine ? TextDecoration.underline : TextDecoration.none)));
}
