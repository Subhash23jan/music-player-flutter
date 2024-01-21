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
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.white54,
    Colors.black12,Colors.white60,Colors.white70,Colors.deepOrange,
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
        // Generate a random duration between 250ms and 1000ms (1 second)
        final randomDuration = Duration(milliseconds: Random().nextInt(1000) + 100);

        // Reset the controller with the new random duration
        _controller.reset();
        _controller.duration = randomDuration;

        // Start the animation
        _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Center(
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
