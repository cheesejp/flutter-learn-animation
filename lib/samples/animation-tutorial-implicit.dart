import 'package:flutter/material.dart';

class AnimatedAlignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedAlignView(),
    );
  }
}

class AnimatedAlignView extends StatefulWidget {
  static const routeName = 'animatedAlign';

  @override
  _AnimatedAlignViewState createState() => _AnimatedAlignViewState();
}

class _AnimatedAlignViewState extends State<AnimatedAlignView> {
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
