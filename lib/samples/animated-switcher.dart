// ==================================================================================================================================
// https://medium.com/flutter-community/what-do-you-know-about-aniamtedswitcher-53cc3a4bebb8
// ==================================================================================================================================

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class AnimatedSwitcherDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  bool isVisible = true;
  int elapsed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Switcher")),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final cd = CountdownTimer(Duration(seconds: 10), Duration(seconds: 1));
        cd.listen((data) {
          setState(() {
            elapsed = cd.elapsed.inSeconds;
            isVisible = !isVisible;
          });
        }, onDone: () {
          cd.cancel();
        });
      }),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            child: Text('Elapsed : $elapsed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
                key: ValueKey(elapsed)),
            duration: Duration(seconds: 1),
            // transitionBuilder: this._slideTransition,
            transitionBuilder: this._slideTransitionWithCurve,
            layoutBuilder:
                (Widget currentChild, List<Widget> previousChildren) {
              return currentChild;
            },
          ),
          AnimatedSwitcher(
            child: isVisible
                ? Container(
                    key: UniqueKey(),
                    height: 200.0,
                    width: 100.0,
                    color: Colors.red,
                  )
                : Container(
                    key: UniqueKey(),
                    height: 200.0,
                    width: 100.0,
                    color: Colors.blue,
                  ),
            duration: Duration(seconds: 1),
            // transitionBuilder: this._rotationTransition,
            // transitionBuilder: this._positionTransition,
            // transitionBuilder: this._slideTransition,
            // transitionBuilder: this._scaleTransition,
            transitionBuilder: this._scaleTransitionWithCurve,
          ),
        ],
      )),
    );
  }

  final _scaleTransition = (Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  };

  final _scaleTransitionWithCurve =
      (Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: animation.drive(
        CurveTween(curve: Curves.easeOutQuint),
      ),
      child: child,
    );
  };

  final _rotationTransition = (Widget child, Animation<double> animation) {
    return RotationTransition(
      alignment: Alignment.bottomCenter,
      turns: animation.drive(CurveTween(curve: Curves.bounceIn)),
      child: child,
    );
  };

  final _positionTransition = (Widget child, Animation<double> animation) {
    return PositionedTransition(
        rect: animation.drive(RelativeRectTween(
            begin: const RelativeRect.fromLTRB(1, 1, 1, 1),
            end: const RelativeRect.fromLTRB(2, 2, 4, 4))),
        child: child);
  };

  final _slideTransition = (Widget child, Animation<double> animation) {
    // return ClipRect(
    //   child: SlideTransition(
    //     child: child,
    //     position: animation.drive(
    //         Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))),
    //   ),
    // );

    return SlideTransition(
      child: child,
      position: animation.drive(
          Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))),
    );
  };

  final _slideTransitionWithCurve =
      (Widget child, Animation<double> animation) {
    return SlideTransition(
      child: child,
      position: animation
          .drive(
            CurveTween(curve: Curves.easeOutQuint),
          )
          .drive(
            Tween<Offset>(
              begin: Offset(0.0, 0.0),
              end: Offset(0.0, -1.0),
            ),
          ),
    );
  };
}
