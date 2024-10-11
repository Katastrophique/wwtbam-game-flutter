import 'dart:math';
import 'question.dart';

class Quiz {
  bool _questionsLoaded = false;
  int _questionNum = 0;
  List<Question> _questionBank = [];
  bool _fiftyFiftyUsed = false;
  bool _seventyFiveTwentyFiveUsed = false;

  // Constructeur pour initialiser les questions
  Quiz() {
    loadQuestions();
  } 

  void loadQuestions() {
    _questionBank = [
      Question("Quel est le plus grand organe du corps humain ?", "Cœur", "Peau", "Foie", "Poumon", "Peau"),
      Question("Quelle vitamine est produite lorsque la peau est exposée au soleil ?", "A", "B", "C", "D", "D"),
      Question("Quel est le principal gaz présent dans l'air que nous respirons ?", "Oxygène", "Azote", "Dioxyde de carbone", "Hélium", "Azote"),
      Question("Quel organe est responsable de la production de l'insuline ?", "Foie", "Pancréas", "Estomac", "Reins", "Pancréas"),
      Question("Quel est le groupe sanguin universel donneur ?", "A", "B", "AB", "O", "O"),
      Question("Quelle maladie est causée par le virus de l'immunodéficience humaine (VIH) ?", "Cancer", "Diabète", "SIDA", "Grippe", "SIDA"),
      Question("Quel est le principal constituant des os ?", "Collagène", "Calcium", "Phosphore", "Potassium", "Calcium"),
      Question("Quel test est utilisé pour mesurer la glycémie ?", "Test de cholestérol", "Test de glucose", "Test d'hémoglobine", "Test de tension artérielle", "Test de glucose"),
      Question("Quel est le nom du virus responsable de la grippe ?", "Influenza", "HIV", "COVID-19", "Ebola", "Influenza"),
      Question("Quel organe est affecté par l'hépatite ?", "Cœur", "Reins", "Foie", "Estomac", "Foie"),
      Question("Quel est le principal composant de l'hémoglobine ?", "Oxygène", "Fer", "Calcium", "Hydrogène", "Fer"),
      Question("Quel est le nom de la maladie caractérisée par une augmentation anormale de la pression artérielle ?", "Hypotension", "Hypertension", "Hypoglycémie", "Hyperglycémie", "Hypertension"),
      Question("Quel organe filtre le sang ?", "Cœur", "Foie", "Reins", "Poumons", "Reins"),
      Question("Quel est le type de cellules responsables de la défense immunitaire ?", "Globules rouges", "Globules blancs", "Plaquettes", "Thrombocytes", "Globules blancs"),
      Question("Quelle est la distance approximative entre la Terre et la Lune ?", "384 400 km", "1 000 000 km", "150 000 km", "500 000 km", "384 400 km"),
      Question("Quel est l'élément chimique représenté par le symbole 'O' ?", "Or", "Oxygène", "Osmium", "Organium", "Oxygène"),
      Question("Quel est le plus grand désert du monde ?", "Sahara", "Arctique", "Antarctique", "Gobi", "Antarctique"),
      Question("Quel est le nom du processus par lequel les plantes fabriquent leur propre nourriture ?", "Respiration", "Photosynthèse", "Transpiration", "Digestion", "Photosynthèse"),
      Question("Quel est le métal liquide à température ambiante ?", "Plomb", "Mercure", "Fer", "Aluminium", "Mercure"),
      Question("Quelle planète est connue comme la planète rouge ?", "Terre", "Vénus", "Mars", "Jupiter", "Mars"),
      Question("Quel est le plus grand océan du monde ?", "Atlantique", "Arctique", "Pacifique", "Indien", "Pacifique"),
      Question("Quel pays est à l'origine des Jeux Olympiques ?", "Italie", "Grèce", "Chine", "France", "Grèce"),
      Question("Quel est le plus petit os du corps humain ?", "Scaphoïde", "Stapes", "Tibia", "Radius", "Stapes"),
      Question("Quelle est l'unité de base de la vie ?", "Cellule", "Atome", "Molécule", "Organe", "Cellule")
    ];
    _questionBank.shuffle();

    _questionsLoaded = true;
  }

    

  Question getQuestion() {
    return _questionBank[_questionNum];
  }

  int getQuestionNumber() {
    return _questionNum + 1;
  }

  void nextQuestion() {
    if (_questionNum < _questionBank.length - 1) {
      _questionNum++;
    }
  }

  void reset() {
    _questionNum = 0;
    _fiftyFiftyUsed = false;
    _seventyFiveTwentyFiveUsed = false;
  }

  bool questionsLoaded() {
    return _questionsLoaded;
  }

  List<String> useFiftyFifty() {
    if (!_fiftyFiftyUsed) {
      _fiftyFiftyUsed = true;
      List<String> options = [
        getQuestion().option1,
        getQuestion().option2,
        getQuestion().option3,
        getQuestion().option4
      ];
      int correctAnswerIndex = options.indexOf(getQuestion().answer);
      List<String> remainingOptions = [options[correctAnswerIndex]];

      // Ajouter une mauvaise réponse au hasard
      options.removeAt(correctAnswerIndex);
      remainingOptions.add(options[Random().nextInt(options.length)]);
      return remainingOptions;
    }
    return [];
  }

  List<String> useSeventyFiveTwentyFive() {
    if (!_seventyFiveTwentyFiveUsed) {
      _seventyFiveTwentyFiveUsed = true;
      List<String> options = [
        getQuestion().option1,
        getQuestion().option2,
        getQuestion().option3,
        getQuestion().option4
      ];
      int correctAnswerIndex = options.indexOf(getQuestion().answer);
      options.removeAt((Random().nextInt(options.length) == correctAnswerIndex) ? 0 : correctAnswerIndex);
      options.removeAt(Random().nextInt(options.length));
      // retourner les réponses restantes
      return options; 
    }
    return [];
  }

  bool isFiftyFiftyUsed() {
    return _fiftyFiftyUsed;
  }

  bool isSeventyFiveTwentyFiveUsed() {
    return _seventyFiveTwentyFiveUsed;
  }
}

Quiz quiz = Quiz();
