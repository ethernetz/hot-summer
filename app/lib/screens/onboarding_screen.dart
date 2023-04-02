import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/onboarding_question.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'package:workspaces/widgets/hot_button.dart';
import 'package:workspaces/widgets/toggle_button.dart';

List<OnboardingQuestion> onboardingQuestions = [
  OnboardingQuestion(
    question: "What's your motivation for working out?",
    answers: ["Lose weight", "Gain muscle", "Get fit", "Get healthy"],
  ),
  OnboardingQuestion(
    question: 'How many times do you want to workout a week?',
    answers: ['1', '2', '3', '4', '5', '6', '7'],
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _questionIndex = 0;
  int? _selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= onboardingQuestions.length) {
      context
          .read<FirestoreService>()
          .completeOnboarding(context, onboardingQuestions);
      return const Text('creating your experience...');
    }

    var question = onboardingQuestions[_questionIndex];

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            question.question,
            style: GoogleFonts.kumbhSans(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          SizedBox(
            width: 275,
            child: Column(
              children: [
                for (int i = 0; i < question.answers.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ToggleButton(
                        isSelected: _selectedAnswerIndex == i,
                        onPressed: () {
                          setState(() {
                            _selectedAnswerIndex = i;
                          });
                        },
                        child: Text(
                          question.answers[i],
                          style: GoogleFonts.kumbhSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          HotButton(
            onPressed: () {
              setState(() {
                onboardingQuestions[_questionIndex]
                    .selectAnswer(_selectedAnswerIndex!);
                _questionIndex++;
                _selectedAnswerIndex = null;
              });
            },
            child: Text(
              'Next',
              style: GoogleFonts.kumbhSans(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
