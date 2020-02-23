// =======================================================================
// https://flutter.dev/docs/development/ui/animations/tutorial#monitoring
// =======================================================================

import 'package:flutter/material.dart';

class TransitionDemo extends StatefulWidget {
  _TransitionDemoState createState() => _TransitionDemoState();
}

class _TransitionDemoState extends State<TransitionDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn)
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
  Widget build(BuildContext context) => GrowTransition(
        child: LogoWidget(),
        animation: _animation,
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// トランジションをレンダリングするクラス。
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

/// ロゴをレンダリングするクラス。
class LogoWidget extends StatelessWidget {
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}
