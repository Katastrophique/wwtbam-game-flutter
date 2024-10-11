import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
import 'dart:math';
import 'quiz.dart';
import 'palier_widget.dart';

void main() {
  // Charger les questions du quiz
  quiz.loadQuestions();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MaterialApp(
      title: 'Qui veut gagner des bactéries',
      theme: ThemeData(fontFamily: 'Source Sans Pro', brightness: Brightness.dark),
      home: HomePage(),
    ));
  });
}

class WorkshopFlutter extends StatefulWidget {
  @override
  _WorkshopFlutter createState() => _WorkshopFlutter();
}

class _WorkshopFlutter extends State<WorkshopFlutter> {
  int _correct = 0;
  late Timer _timer;
  // Timer initial
  int _start = 15;
  // Numéro local de la question
  int _qNumLocal = 0;
  // Liste des scores visuels
  List<Widget> score = [];
  // Les paliers sécurisés
  final List<int> securedPaliers = [1000, 32000];
  // Dernier palier sécurisé atteint
  int lastSecuredPalier = 0;
  bool _joker5050Used = false; // État du joker 50:50
  bool _audienceUsed = false; // État du joker vote du public
  List<String> _optionsVisible = []; // Options visibles après 50:50

  @override
  void initState() {
    super.initState();
    _optionsVisible = [
      quiz.getQuestion().option1,
      quiz.getQuestion().option2,
      quiz.getQuestion().option3,
      quiz.getQuestion().option4,
    ]; // Initialisation des options visibles
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) => setState(() {
        if (_start < 1) {
          // Si le timer est écoulé, c'est une mauvaise réponse
          checkAnswer(null);
        } else {
          _start--;
        }
      }),
    );
  }

  void resetTimer() {
    setState(() {
      // Réinitialiser le timer pour chaque nouvelle question
      _start = 15;
    });
  }

  void restartGame() async {
    setState(() {
      _qNumLocal = 0;
      _correct = 0;
      lastSecuredPalier = 0; // Réinitialiser le palier sécurisé
      quiz.reset(); // Réinitialiser et mélanger les questions
      score = [];
      resetTimer();
      _joker5050Used = false;
      _audienceUsed = false;
      _optionsVisible = [
        quiz.getQuestion().option1,
        quiz.getQuestion().option2,
        quiz.getQuestion().option3,
        quiz.getQuestion().option4,
      ]; // Réinitialiser les options visibles
    });

    await Future.delayed(const Duration(milliseconds: 500));

    // Utiliser Navigator.pushReplacement pour redémarrer le jeu
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WorkshopFlutter()),
    );
  }

  void displayResult(String resultMessage, AlertType resultType) {
    _timer.cancel();

    // Si aucun palier sécurisé n'est atteint, on prend en compte le score actuel
    int finalScore = lastSecuredPalier > 0 ? lastSecuredPalier : (_qNumLocal * 100);

    List<DialogButton> buttons = [
      DialogButton(
        child: Text(
          "Rejouer",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => restartGame(),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      ),
    ];

    Alert(
      context: context,
      type: resultType,
      title: resultMessage,
      desc: "Votre score: ${finalScore} Bactéries.",
      style: AlertStyle(
        backgroundColor: Colors.blueGrey[900],
        isCloseButton: false,
        descStyle: TextStyle(color: Colors.white, fontSize: 15.0),
        titleStyle: TextStyle(color: Colors.white),
        isOverlayTapDismiss: false,
      ),
      buttons: buttons,
    ).show();
  }

  void checkAnswer(String? choice) {
    if (_qNumLocal < 15 && choice != null) {
      setState(() {
        // Vérification de la réponse
        if (choice == quiz.getQuestion().answer) {
          _correct++;
          score.add(_buildScoreIndicator(Colors.green));

          // Mise à jour du palier sécurisé
          updateSecuredPalier();

          _qNumLocal++;
          quiz.nextQuestion();
          resetTimer();

          // Réinitialiser les options visibles
          _optionsVisible = [
            quiz.getQuestion().option1,
            quiz.getQuestion().option2,
            quiz.getQuestion().option3,
            quiz.getQuestion().option4,
          ];
        } else {
          // Mauvaise réponse : afficher les résultats immédiatement et terminer le jeu
          score.add(_buildScoreIndicator(Colors.red));
          displayResult("Vous avez perdu!", AlertType.error);
        }
      });
    }

    if (_qNumLocal >= 15) {
      // Si toutes les questions sont répondues, afficher le résultat
      displayResult("Félicitations! Vous avez gagné!", AlertType.success);
    }
  }

  void updateSecuredPalier() {
    // Si le joueur atteint un palier sécurisé, mettre à jour
    if (_qNumLocal == 4 || _qNumLocal == 9) {  // Correspond aux paliers 5 et 10
      lastSecuredPalier = securedPaliers[securedPaliers.indexOf(lastSecuredPalier) + 1];
    }
  }

  Widget _buildScoreIndicator(Color color) {
    return Container(
      height: 18.0,
      width: 18.0,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Center(
        child: Text(
          quiz.getQuestionNumber().toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildTimer(),
                      _buildQuestionContainer(),
                      _buildOptions(),
                      _buildJokers(),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Affichage des scores visuels
                    children: score,
                  ),
                ],
              ),
            ),
          ),
          // Intégration du PalierWidget
          PalierWidget(currentLevel: _qNumLocal),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
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
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContainer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[900],
        ),
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints(
          maxWidth: 550,
        ),
        child: Center(
          child: Text(
            quiz.getQuestion().questionText,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (_optionsVisible.contains(quiz.getQuestion().option1))
                _buildOptionButton(quiz.getQuestion().option1),
              if (_optionsVisible.contains(quiz.getQuestion().option2))
                _buildOptionButton(quiz.getQuestion().option2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (_optionsVisible.contains(quiz.getQuestion().option3))
                _buildOptionButton(quiz.getQuestion().option3),
              if (_optionsVisible.contains(quiz.getQuestion().option4))
                _buildOptionButton(quiz.getQuestion().option4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String optionText) {
    return Container(
      width: 250,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          checkAnswer(optionText);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.grey),
          ),
          padding: const EdgeInsets.all(8.0),
        ),
        child: Text(
          optionText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  // Widgets pour les jokers
  Widget _buildJokers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _joker5050Used ? null : () {
            setState(() {
              _joker5050Used = true;
              // Logique du 50:50
              _optionsVisible = _applyFiftyFifty();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _joker5050Used ? Colors.grey : Colors.blue, // Grise le bouton si utilisé
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text("50:50"),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: _audienceUsed ? null : () {
            setState(() {
              _audienceUsed = true;
              _showAudienceVote();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _audienceUsed ? Colors.grey : Colors.blue, // Grise le bouton si utilisé
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text("Vote du public"),
        ),
      ],
    );
  }

  List<String> _applyFiftyFifty() {
    // Fonctionnalité du joker 50:50, garde la bonne réponse et une mauvaise réponse
    List<String> options = [
      quiz.getQuestion().option1,
      quiz.getQuestion().option2,
      quiz.getQuestion().option3,
      quiz.getQuestion().option4
    ];
    options.removeWhere((option) => option != quiz.getQuestion().answer);

    // Ajoute une mauvaise réponse au hasard
    var incorrectOptions = [
      quiz.getQuestion().option1,
      quiz.getQuestion().option2,
      quiz.getQuestion().option3,
      quiz.getQuestion().option4
    ];
    incorrectOptions.removeWhere((option) => option == quiz.getQuestion().answer);
    options.add(incorrectOptions[Random().nextInt(incorrectOptions.length)]);
    return options;
  }

  void _showAudienceVote() {
    // Simulation d'un vote du public (résultats aléatoires)
    Alert(
      context: context,
      title: "Résultat du vote",
      desc: "A: 40%\nB: 30%\nC: 20%\nD: 10%",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(8.0),
                ),
                child: Text(
                  "Start Game",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Pacifico",
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkshopFlutter()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
