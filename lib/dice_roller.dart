import 'dart:math';
import 'package:flutter/material.dart';
import 'styled_text.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;
  int rollCount = 0;
  List<int> diceRolls = List.filled(5, 0);

  void rollDice() {
    setState(() {
      if (rollCount < 5) {
        currentDiceRoll = randomizer.nextInt(6) + 1;
        // print('${currentDiceRoll}');
        diceRolls[rollCount++] = currentDiceRoll;
      }
    });
  }
  
  void resetGame() {
    setState(() {
      currentDiceRoll = 2;
      diceRolls = List.filled(5, 0);
      rollCount = 0;
    });
  }

  @override
  Widget build(context) {
    int totalScore = diceRolls.fold(0, (previousValue, element) => previousValue + element);
    String message = '$totalScore/20';
    String buttonText = rollCount < 5 ? 'Roll Dice' : 'Play again';


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Your Score:',
          style: TextStyle(
            fontSize: 24, 
            color: Colors.white,
          ),
        ),
        Text(
          message,
          style: const TextStyle(
            fontSize: 32, 
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollCount < 5 ? rollDice : resetGame,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(
            //   top: 20,
            // ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: StyledText(buttonText),
        )
      ],
    );
  }
}
