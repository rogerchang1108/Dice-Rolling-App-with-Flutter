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

  void _rollDice() {
    setState(() {
      if (rollCount < 5) {
        currentDiceRoll = randomizer.nextInt(6) + 1;
        diceRolls[rollCount++] = currentDiceRoll;
      }
    });
  }
  
  void _resetGame() {
    setState(() {
      currentDiceRoll = 2;
      diceRolls = List.filled(5, 0);
      rollCount = 0;
    });
  }
  
  String _getRoundSuffix(int number) {
    switch (number) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  @override
  Widget build(context) {
    int totalScore = diceRolls.fold(0, (previousValue, element) => previousValue + element);
    String message = 'Your Score:';
    String showScore = '$totalScore/20';
    String buttonText = 'Roll Dice';
    
    if (rollCount == 5) {
      message = totalScore >= 20 ? 'You win!' : 'You lose!';
      buttonText = 'Play again';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: const TextStyle(
            fontSize: 24, 
            color: Colors.white,
          ),
        ),
        Text(
          showScore,
          style: const TextStyle(
            fontSize: 32, 
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Text(
                      _getRoundSuffix(i + 1),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      diceRolls[i] == 0 ? '--' : diceRolls[i].toString(),
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: rollCount < 5 ? _rollDice : _resetGame,
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
