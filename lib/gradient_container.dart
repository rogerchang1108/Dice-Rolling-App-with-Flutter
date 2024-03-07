import 'package:flutter/material.dart';

import 'dice_roller.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatefulWidget {
  const GradientContainer({super.key});

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  Color color1 = const Color.fromARGB(255, 33, 5, 109);
  Color color2 = const Color.fromARGB(255, 68, 21, 149);

  void _changeColor(int totalScore) {
    if(totalScore >= 20) {
      setState(() {
        color1 = const Color.fromARGB(255, 0, 91, 0);
        color2 = const Color.fromARGB(255, 42, 146, 42);
      });
    } else if (totalScore == 0) {
      setState(() {
        color1 = const Color.fromARGB(255, 33, 5, 109);
        color2 = const Color.fromARGB(255, 68, 21, 149);
      });
    } else {
      setState(() {
        color1 = const Color.fromARGB(255, 188, 11, 46);
        color2 = const Color.fromARGB(255, 251, 51, 81);
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget = DiceRoller(changeColor: _changeColor);

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [color1, color2],
          stops: const [0.0, 1.0],
          center: Alignment.center,
          radius: 1.0,
        ),
      ),
      child: Center(
        child: screenWidget,
      ),
    );
  }
}
