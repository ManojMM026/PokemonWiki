import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/widget/text_util.dart';

class PokedexAppBar {
  final String title;
  final Function onLeadingPressed;
  final Widget leading;
  final List<Widget> actions;
  final Widget titleWidget;
  final Color backgroundColor;
  final Color leadingIconColor;
  final Color titleColor;
  final bool shouldAnimate;
  final PreferredSizeWidget tabBar;
  final double leadingWidth;
  final bool automaticallyImplyLeading;

  PokedexAppBar(
      {@required this.title,
      this.onLeadingPressed,
      this.automaticallyImplyLeading,
      this.titleColor,
      this.backgroundColor,
      this.leading,
      this.leadingWidth,
      this.leadingIconColor,
      this.tabBar,
      this.actions,
      this.shouldAnimate,
      this.titleWidget});

  AppBar appBar({@required BuildContext context}) {
    return AppBar(
      title: titleWidget != null ? titleWidget : _appBarTitle(context),
      leading: leading != null ? leading : _appBackButton(context),
      actions: actions,
      elevation: 0,
      leadingWidth: leadingWidth != null ? leadingWidth : 56,
      automaticallyImplyLeading:
          automaticallyImplyLeading != null ? automaticallyImplyLeading : true,
      // Don't show the leading button
      bottom: tabBar,
      backgroundColor:
          backgroundColor != null ? backgroundColor : Colors.transparent,
    );
  }

  Widget _appBarTitle(context) {
    return shouldAnimate != null && shouldAnimate
        ? _animatedTitle(context)
        : headline6(
            context,
            title,
            color: titleColor == null ? Colors.black : titleColor,
          );
  }

  Widget _animatedTitle(context) {
    return FadeInDown(
        animate: shouldAnimate != null ? shouldAnimate : false,
        from: 10,
        delay: Duration(milliseconds: AppConstants.animationDurationDelay),
        child: headline6(
          context,
          title,
          color: titleColor == null ? Colors.black : titleColor,
        ));
  }

  Widget _animatedBackButton(context) {
    return FadeInLeft(
      from: 20,
      animate: shouldAnimate != null ? shouldAnimate : false,
      delay: Duration(milliseconds: AppConstants.animationDurationDelay),
      child: InkWell(
          onTap: () => onLeadingPressed(),
          child: Icon(
            CupertinoIcons.back,
            color: leadingIconColor == null ? Colors.black : leadingIconColor,
          )),
    );
  }

  Widget _appBackButton(context) {
    return shouldAnimate != null && shouldAnimate
        ? _animatedBackButton(context)
        : InkWell(
            onTap: () => onLeadingPressed(),
            child: Icon(
              Icons.keyboard_backspace,
              color: leadingIconColor == null ? Colors.black : leadingIconColor,
            ));
  }
}
