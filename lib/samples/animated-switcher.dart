import 'package:flutter/material.dart';

class AnimatedSwitcherDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Switcher")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
      ),
      body: Center(
          child: AnimatedSwitcher(
        child: isVisible
            ? Container(
                height: 100.0,
                width: 100.0,
                color: Colors.red,
              )
            : SizedBox(),
        duration: Duration(seconds: 2),
      )),
    );
  }
}
