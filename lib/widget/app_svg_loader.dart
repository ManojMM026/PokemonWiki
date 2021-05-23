import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgLoader extends StatelessWidget {
  final String svg;
  final Size svgSize;
  final Color color;

  AppSvgLoader(
      {@required this.svg, this.svgSize = const Size(20, 20), this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      color: color,
      height: svgSize.height,
      width: svgSize.width,
    );
  }
}
