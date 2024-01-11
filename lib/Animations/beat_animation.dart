import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BeatButton extends StatefulWidget {
  const BeatButton({Key? key}) : super(key: key);

  @override
  _BeatButtonState createState() => _BeatButtonState();
}

class _BeatButtonState extends State<BeatButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
    Colors.yellowAccent,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.black,
    ).animate(_controller);

    _controller.addListener(() {
      // Change color at each iteration
      int randomIndex = Random().nextInt(colorList.length);
      _colorAnimation = ColorTween(
        begin: _colorAnimation.value,
        end: _controller.status == AnimationStatus.forward ? colorList[randomIndex] : Colors.black,
      ).animate(_controller);
    });

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle button tap
      },
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.45,
            color: _colorAnimation.value,
            child: Center(
              child: Text(
                'Play',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
