import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'quiz.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(new WWTBAM());
  });
}

class WWTBAM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: WWTBAMGame(),
    );
  }
}

class WWTBAMGame extends StatefulWidget {
  @override
  _WWTBAMGameState createState() => _WWTBAMGameState();
}

class _WWTBAMGameState extends State<WWTBAMGame> {
  Quiz quiz = new Quiz();
//  int timerCount = 15;
//  void countDownTimer() async {
//    timerCount = 15;
//    for (int x = 15; x > 0; x--) {
//      await Future.delayed(Duration(milliseconds: 1500)).then((_) {
//        setState(() {
//          if(timerCount==1) checkAnswer(null);
//          timerCount -= 1;
//        });
//      });
//    }
//  }

  void checkAnswer(String choice)
  {
    if(quiz.getQuestionNumber()>=15) {
      Alert(context: context, title: "Who Wants to Be a Millionaire", desc: "GameOver").show();
    }
    setState(() {
    if(choice==quiz.getQuestion().answer)
    {
      score.add(
      Container(
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
    }
    else{
      score.add(
          Container(
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
    quiz.nextQuestion();
    //countDownTimer();
    });
  }


  List<Widget> score = [ ];

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
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CountdownFormatted(
                              duration: Duration(seconds: 10),
                              builder: (BuildContext ctx, String remaining) {
                                return Text(
                                  remaining,
                                  style: TextStyle(fontSize: 30),
                                ); // 01:00:00
                              },
                            ),
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
                          onPressed: () {checkAnswer(quiz.getQuestion().option1);},
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
                          onPressed: (){checkAnswer(quiz.getQuestion().option3);},
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
                          onPressed: (){checkAnswer(quiz.getQuestion().option4);},
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

Widget get scoreElem {
  return Container(
    height: 18.0,
    width: 18.0,
    margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100), color: Colors.green),
    child: Center(
      child: Text(
        "1",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
