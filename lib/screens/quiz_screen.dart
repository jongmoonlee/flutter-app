import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizScreen extends StatefulWidget {
  static const String id = 'quiz_screen';
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Icon> scoreKeeper = [];
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
                context: context,
                title: 'Finished',
                desc: 'You\'ve reached the end of the quiz.')
            .show();
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 100.0,
                            child: IconButton(
                                icon: Icon(Icons.language),
                                onPressed: () {
                                  print('clicked');
                                }),
                          ),
                        ]),
                    SizedBox(
                      height: 100.0,
                    ),
                    Text(
                      quizBrain.getQuestionText(),
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(true);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: FlatButton(
                  color: Colors.red,
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(false);
                  },
                ),
              ),
            ),
            Row(
              children: scoreKeeper,
            )
          ],
        ),
      ),
    );
  }
}
