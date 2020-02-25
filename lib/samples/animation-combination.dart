// ==================================================================================================================================
// https://flutter.dev/docs/development/ui/animations/tutorial#monitoring
// ==================================================================================================================================

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationConbinationDemo extends StatefulWidget {
  _AnimationConbinationDemoState createState() =>
      _AnimationConbinationDemoState();
}

class _AnimationConbinationDemoState extends State<AnimationConbinationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CardShotTransition(
          child: CardWidget(
            () {
              _animationController.forward();
            },
          ),
          controller: _animationController,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => _animationController.reverse(),
        ),
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CardShotTransition extends StatelessWidget {
  CardShotTransition({this.child, this.controller});

  final Widget child;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    Animation<double> rotateAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeInBack),
    );
    // Tween<double> rotateTween = Tween<double>(begin: 0, end: 7);
    Tween<double> rotateTween = Tween<double>(begin: 0, end: 0.25);

    Animation<double> alignAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(0.5, 0.8, curve: Curves.easeInBack),
    );
    AlignmentTween alignTween =
        AlignmentTween(begin: Alignment(0.0, 0.0), end: Alignment(0.0, -4.0));

    return Center(
      child: AnimatedBuilder(
          animation: rotateAnimation,
          child: child, // ここで指定したchildがbuilderの匿名関数に渡される。
          builder: (context, child) {
            return Align(
              alignment: alignTween.evaluate(alignAnimation),
              child: Transform.rotate(
                angle: rotateTween.evaluate(rotateAnimation) * 2 * math.pi,
                child: child,
              ),
            );
          }),
    );
  }
}

class CardWidget extends StatelessWidget {
  CardWidget(this._pressed);
  final void Function() _pressed;

  Widget build(BuildContext context) => Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('Title'),
              subtitle: Text('Sub title'),
            ),
            ButtonBarTheme(
              data: ButtonBarThemeData(),
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: _pressed,
                    child: const Text('開始'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
