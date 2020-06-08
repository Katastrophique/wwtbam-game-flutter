import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'quiz.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(new MaterialApp(
      title: 'WWTBAM',
      theme: ThemeData.dark(),
      home: HomePage(),
    ));
  });
}

//class WWTBAM extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData.dark(),
//      home: WWTBAMGame(),
//    );
//  }
//}

class WWTBAMGame extends StatefulWidget {
  @override
  _WWTBAMGameState createState() => _WWTBAMGameState();
}

class _WWTBAMGameState extends State<WWTBAMGame> {
  Quiz quiz = new Quiz();
  int _correct = 0;
  Timer _timer;
  int _start = 15;
  int _qNumLocal = 0;

  void restartGame() async{
    _qNumLocal = 0;
    _correct = 0;
    quiz.reset();
    startTimer();
    score = [];
    await new Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }

  void resetTimer() {
    setState(() {
      _start = 15;
    });
  }

  void startTimer() {
    _timer = new Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            checkAnswer(null);
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void displayResult() {
    _timer.cancel();
    String _result;
    AlertType _resultType;
    if (_correct >= 8) {
      _result = "You won!";
      _resultType = AlertType.success;
    } else {
      _result = "You lose!";
      _resultType = AlertType.error;
    }
    Alert(
      context: context,
      type: _resultType,
      title: _result,
      desc: "Who Wants to Be a Millionaire",
      style: AlertStyle(
        backgroundColor: Colors.blueGrey[900],
        isCloseButton: false,
        descStyle: TextStyle(color: Colors.white, fontSize: 10.0),
        titleStyle: TextStyle(color: Colors.white),
        isOverlayTapDismiss: false,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Play again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => restartGame(),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void checkAnswer(String choice) {
    if (_qNumLocal <= 14)
      setState(() {
        if (choice == quiz.getQuestion().answer) {
          _correct++;
          score.add(Container(
            height: 18.0,
            width: 18.0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.green),
            child: Center(
              child: Text(
                quiz.getQuestionNumber().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ));
        } else {
          score.add(Container(
            height: 18.0,
            width: 18.0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.red),
            child: Center(
              child: Text(
                quiz.getQuestionNumber().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ));
        }
        _qNumLocal++;
        quiz.nextQuestion();
        resetTimer();
      });
    if (_qNumLocal >= 15) {
      displayResult();
      return;
    }
  }

  List<Widget> score = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: 55.0,
                  height: 55.0,
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    color: Colors.white,
                    child: ClipRRect(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "$_start",
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey[900],
                    ),
                    padding: EdgeInsets.all(10.0),
                    constraints: BoxConstraints(maxWidth: 550),
                    child: Center(
                      child: Text(
                        quiz.getQuestion().questionText,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 250,
                        height: 60,
                        child: FlatButton(
                          onPressed: () {
                            checkAnswer(quiz.getQuestion().option1);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              quiz.getQuestion().option1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 250,
                        height: 60,
                        child: FlatButton(
                          onPressed: () {
                            checkAnswer(quiz.getQuestion().option2);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              quiz.getQuestion().option2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 250,
                        height: 60,
                        child: FlatButton(
                          onPressed: () {
                            checkAnswer(quiz.getQuestion().option3);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              quiz.getQuestion().option3,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 250,
                        height: 60,
                        child: FlatButton(
                          onPressed: () {
                            checkAnswer(quiz.getQuestion().option4);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              quiz.getQuestion().option4,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: score,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: FlatButton(
              color: Colors.blueGrey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Start Game",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    backgroundColor: Colors.blueGrey[900],
                  ),),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WWTBAMGame()))),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover),
          ),
          constraints: BoxConstraints.expand(),
        ),
      );
  }
}
