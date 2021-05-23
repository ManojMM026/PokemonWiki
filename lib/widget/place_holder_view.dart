import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/widget/app_svg_loader.dart';
import 'package:mypokedex/widget/text_util.dart';
class PlaceHolderView extends StatelessWidget {
  final String placeHolderText;

  PlaceHolderView({this.placeHolderText});

  @override
  Widget build(BuildContext context) {
    return _placeHolder(context, placeHolderText);
  }

  Widget _placeHolder(BuildContext context, String text) {
    return Container(
      child: Center(
          child: FadeIn(
              delay:
                  Duration(milliseconds: AppConstants.animationDurationDelay),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinPerfect(
                    infinite: true,
                    child: AppSvgLoader(
                      // svg: 'assets/icons/normal.svg',
                      svg: 'assets/icons/pokeball.svg',
                      svgSize: Size(100, 100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: subtitle1(context, text),
                  ),
                ],
              ))),
    );
  }
}
