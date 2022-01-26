import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuestionBrain questionBrain = QuestionBrain();
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = questionBrain.getQuestionAnswer();

    setState(() {
      if (questionBrain.isFinished()) {
        Alert(
          context: context,
          title: 'Finished',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        questionBrain.reset();
        scoreKeeper.clear();
      } else {
        if (correctAnswer == userPickedAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }

        questionBrain.nextQuestion();
      }
    });
  }

  /// Create TextButton to show True or False
  Widget getAnswerButton({
    required Color bgColor,
    required String label,
    required bool userPickedAnswer,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () => checkAnswer(userPickedAnswer),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        getAnswerButton(
          bgColor: Colors.green,
          label: 'True',
          userPickedAnswer: true,
        ),
        getAnswerButton(
          bgColor: Colors.red,
          label: 'False',
          userPickedAnswer: false,
        ),
        Row(children: scoreKeeper),
        SizedBox(height: 30),
      ],
    );
  }
}
