import 'package:flutter/material.dart';
import 'package:word_hurdle_puzzle/wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;

  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(),
        border: Border.all(
          color: Colors.cyan,
          width: 1.5,
        ),
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          fontSize: 16,
          color: _getTextColor(),
        ),
      ),
    );
  }

  /// Determines the background color based on wordle state
  Color? _getBackgroundColor() {
    if (wordle.isCorrect) {
      return Colors.greenAccent;
    } else if (wordle.existsinTarget) {
      return Colors.yellowAccent;
    } else if (wordle.doesNotExistinTarget) {
      return Colors.redAccent;
    }
    return null;
  }

  /// Determines the text color based on wordle state
  Color _getTextColor() {
    if (wordle.isCorrect || wordle.existsinTarget || wordle.doesNotExistinTarget) {
      return Colors.black;
    }
    return Colors.white;
  }
}
