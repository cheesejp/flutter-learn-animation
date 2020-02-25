import 'package:animation/samples/animated-switcher.dart';
import 'package:animation/samples/animated-align.dart';
import 'package:animation/samples/animation-combination.dart';
import 'package:animation/samples/animation-tutorial-transition.dart';
import 'package:animation/samples/bottom-navigation-bar.dart';
import 'package:animation/samples/change-navigation-animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyTab());
}

class MyTab extends StatelessWidget {
  final List<Widget> animationViews = [
    ChangeNavigationAnimation(),
    AnimationConbinationDemo(),
    AnimatedSwitcherDemo(),
    AnimatedAlignDemo(),
    BottomNavigationDemo(type: BottomNavigationDemoType.withLabels),
    TransitionDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: animationViews.length,
          child: TabBarView(children: animationViews)),
    );
  }
}
