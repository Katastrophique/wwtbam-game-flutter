import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question.dart';
class Quiz
{
  bool _questionsLoaded = false;
  int _questionNum = 0;
  List<Question> _questionBank = [
  ];

  Question getQuestion()
  {
    return _questionBank[_questionNum];
  }

  int getQuestionNumber()
  {
    return _questionNum+1;
  }

  void nextQuestion()
  {
    if(_questionNum < _questionBank.length -1)
      _questionNum++;
  }
  void reset()
  {
    _questionNum=0;
  }

  void loadQuestion() async {
    final response = await http.get('https://mcq-quiz-app.herokuapp.com/getBulk/a2cb0227029f294cdc857e485dcafc807856b3a4/30');
    if (response.statusCode == 200) {
      for(int i=0;i<30;i++)
        _questionBank.add(Question.fromJson(json.decode(response.body)[i]));
      _questionsLoaded = true;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  bool questionsLoaded() {
    return _questionsLoaded;
  }
}
Quiz quiz = new Quiz();

