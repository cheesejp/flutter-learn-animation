// =======================================================================
// https://flutter.dev/docs/development/ui/animations/tutorial#monitoring
// =======================================================================

import 'package:flutter/material.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeIn)
      // _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addStatusListener(
        (status) {
          print(status);
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          }
          if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
      );
    _animationController.forward();
  }

  @override
  // Widget build(BuildContext context) => AnimatedLogo(animation: _animation);
  Widget build(BuildContext context) => GrowTransition(
        child: LogoWidget(),
        animation: _animation,
      );
}

// トランジションをレンダリングする
class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Opacity(
                  opacity: _opacityTween.evaluate(animation),
                  child: Container(
                    height: _sizeTween.evaluate(animation),
                    width: _sizeTween.evaluate(animation),
                    child: child,
                  ),
                ),
            child: child),
      );
}

// ロゴをレンダリングする
class LogoWidget extends StatelessWidget {
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}
