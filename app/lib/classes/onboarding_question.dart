class OnboardingQuestion {
  final String question;
  final List<String> answers;
  int? selectionIndex;

  OnboardingQuestion({
    required this.question,
    required this.answers,
  });

  void selectAnswer(int index) {
    selectionIndex = index;
  }
}
