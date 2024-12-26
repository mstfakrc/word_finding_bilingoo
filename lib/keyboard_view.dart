import 'package:flutter/material.dart';

// Keyboard rows definition
const keysList = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
];

class KeyboardView extends StatelessWidget {
  final List<String> excludedLetters; // Letters to be excluded
  final ValueChanged<String> onPressed; // Callback for button press

  const KeyboardView({
    super.key,
    required this.excludedLetters,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: keysList
              .map((row) => _buildKeyRow(row))
              .toList(),
        ),
      ),
    );
  }

  /// Builds a row of virtual keys
  Widget _buildKeyRow(List<String> rowKeys) {
    return Row(
      children: rowKeys
          .map(
            (key) => VirtualKey(
              letter: key,
              excluded: excludedLetters.contains(key),
              onPress: onPressed,
            ),
          )
          .toList(),
    );
  }
}

class VirtualKey extends StatelessWidget {
  final String letter; // The letter displayed on the key
  final bool excluded; // Whether the letter is excluded
  final ValueChanged<String> onPress; // Callback for key press

  const VirtualKey({
    super.key,
    required this.letter,
    required this.excluded,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: excluded ? Colors.red : Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        onPressed: () => onPress(letter),
        child: Text(letter),
      ),
    );
  }
}
