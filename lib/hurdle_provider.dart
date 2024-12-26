import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:word_hurdle_puzzle/wordle.dart';

class HurdleProvider extends ChangeNotifier {
  // Constants
  static const int lettersPerRow = 5;
  static const int totalAttempts = 6;

  // Game State
  final Random _random = Random.secure();
  List<String> _totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];
  String targetWord = '';
  int attempts = 0;
  int _currentInputIndex = 0;
  bool wins = false;

  /// Initialize game
  void init() {
    _loadWords();
    _generateBoard();
    _setRandomTargetWord();
  }

  /// Load valid 5-letter words
  void _loadWords() {
    _totalWords = words.all.where((word) => word.length == lettersPerRow).toList();
  }

  /// Generate initial game board
  void _generateBoard() {
    hurdleBoard = List.generate(lettersPerRow * totalAttempts, (_) => Wordle(letter: ''));
  }

  /// Set a random target word
  void _setRandomTargetWord() {
    targetWord = _totalWords[_random.nextInt(_totalWords.length)].toUpperCase();
    print("Target Word: $targetWord");
  }

  // Getters
  bool get isAValidWord => _totalWords.contains(rowInputs.join('').toLowerCase());
  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;
  bool get noAttemptsLeft => attempts == totalAttempts;

  /// Handle letter input
  void inputLetter(String letter) {
    if (rowInputs.length < lettersPerRow) {
      rowInputs.add(letter);
      hurdleBoard[_currentInputIndex] = Wordle(letter: letter);
      _currentInputIndex++;
      notifyListeners();
    }
  }

  /// Handle deleting a letter
  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeLast();
      _currentInputIndex--;
      hurdleBoard[_currentInputIndex] = Wordle(letter: '');
      notifyListeners();
    }
  }

  /// Check the player's input against the target word
  void checkAnswer() {
    final input = rowInputs.join('');
    if (input == targetWord) {
      wins = true;
    } else {
      _markLettersOnBoard();
      if (attempts < totalAttempts - 1) {
        _moveToNextRow();
      }
    }
    notifyListeners();
  }

  /// Mark letters on the board based on their correctness
  void _markLettersOnBoard() {
    final rowStart = attempts * lettersPerRow;
    final rowEnd = rowStart + lettersPerRow;

    for (int i = rowStart; i < rowEnd; i++) {
      final letter = hurdleBoard[i].letter;
      if (letter.isEmpty) continue;

      if (targetWord[i % lettersPerRow] == letter) {
        hurdleBoard[i].isCorrect = true;
      } else if (targetWord.contains(letter)) {
        hurdleBoard[i].existsinTarget = true;
      } else {
        hurdleBoard[i].doesNotExistinTarget = true;
        if (!excludedLetters.contains(letter)) {
          excludedLetters.add(letter);
        }
      }
    }
  }

  /// Move to the next row for a new attempt
  void _moveToNextRow() {
    attempts++;
    rowInputs.clear();
  }

  /// Reset the game to its initial state
  void reset() {
    rowInputs.clear();
    excludedLetters.clear();
    hurdleBoard.clear();
    attempts = 0;
    _currentInputIndex = 0;
    wins = false;
    targetWord = '';
    _generateBoard();
    _setRandomTargetWord();
    notifyListeners();
  }
}
