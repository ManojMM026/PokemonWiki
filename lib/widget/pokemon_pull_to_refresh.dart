import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PokemonPullToRefresh extends StatelessWidget {
  final Function onLoading;
  final Function onRefresh;
  final Widget child;
  final EasyRefreshController controller;

  PokemonPullToRefresh(
      {@required this.child,
      @required this.onLoading,
      @required this.onRefresh,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      topBouncing: true,
      bottomBouncing: true,
      header: ClassicalHeader(
          infoColor: Theme.of(context).textTheme.bodyText2.color,
          textColor: Theme.of(context).textTheme.bodyText2.color),
      footer: ClassicalFooter(
          infoColor: Theme.of(context).textTheme.bodyText2.color,
          textColor: Theme.of(context).textTheme.bodyText2.color),
      onLoad: onLoading,
      onRefresh: onRefresh,
      controller: controller,
      child: child,
    );
  }
}
