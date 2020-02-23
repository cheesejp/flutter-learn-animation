// ==================================================================================================================================
// https://medium.com/flutter-jp/implicit-animation-b9d4b7358c28
// ==================================================================================================================================

import 'package:flutter/material.dart';

class AnimatedAlignDemo extends StatefulWidget {
  static const routeName = 'animatedAlign';

  @override
  _AnimatedAlignDemoState createState() => _AnimatedAlignDemoState();
}

class _AnimatedAlignDemoState extends State<AnimatedAlignDemo> {
  static const _alignments = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft,
    Alignment(-1.5, 0.0),
  ];

  var _index = 0;
  AlignmentGeometry get _alignment {
    print(_index % _alignments.length);
    return _alignments[_index % _alignments.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('AnimatedAlign')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _index++;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: AnimatedAlign(
        alignment: _alignment,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
        curve: Curves.easeInOut,
      ),
    );
  }
}
