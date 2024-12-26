class Wordle{
  String letter;
  bool existsinTarget;
  bool doesNotExistinTarget;
  bool isCorrect;

  Wordle({
    required this.letter,
    this.existsinTarget = false,
    this.doesNotExistinTarget = false,
    this.isCorrect = false,
  });

}