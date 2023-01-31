import 'package:flutter/material.dart';

class MaterialPageRouteWithFadeTransition<T> extends MaterialPageRoute<T> {
  final Duration duration;
  MaterialPageRouteWithFadeTransition({
    required WidgetBuilder builder,
    this.duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);
  @override
  Duration get transitionDuration => duration;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
  }
}

class DefaultMaterialPageRoute<T> extends MaterialPageRoute<T> {
  final Duration duration;
  DefaultMaterialPageRoute({
    required WidgetBuilder builder,
    this.duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);
  @override
  Duration get transitionDuration => duration;
  // @override
  // Widget buildTransitions(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation, Widget child) {
  //   const begin = Offset(0.0, 1.0);
  //   const end = Offset.zero;
  //   const curve = Curves.ease;

  //   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //   return SlideTransition(
  //     position: animation.drive(tween),
  //     child: child,
  //   );
  // }
}
