import 'dart:math';
import 'question.dart';

class Quiz {
  bool _questionsLoaded = false;
  int _questionNum = 0;
  List<Question> _questionBank = [];
  // Variable pour suivre la question précédente
  int _previousQuestionNum = -1;
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
      Question("Quel est le rôle principal des globules rouges ?", "Transport d'oxygène", "Défense immunitaire", "Coagulation", "Régulation de la température", "Transport d'oxygène"),
      Question("Quel est le nom scientifique de la grippe ?", "Influenza", "Varicelle", "COVID-19", "Hépatite B", "Influenza"),
      Question("Comment appelle-t-on l’inflammation des articulations ?", "Ostéoporose", "Arthrite", "Scoliose", "Fibromyalgie", "Arthrite"),
      Question("Quel est l'organe principalement affecté par la cirrhose ?", "Pancréas", "Foie", "Cerveau", "Reins", "Foie"),
      Question("Quel est l'agent responsable du paludisme ?", "Virus", "Bactérie", "Parasite", "Champignon", "Parasite"),
      Question("Quel est le traitement standard pour une infection bactérienne ?", "Antibiotiques", "Antiviraux", "Antifongiques", "Vaccins", "Antibiotiques"),
      Question("Quel est le nom médical pour une crise cardiaque ?", "Angine", "Infarctus du myocarde", "AVC", "Embolie", "Infarctus du myocarde"),
      Question("Quel élément est essentiel pour la formation de l'hémoglobine ?", "Sodium", "Fer", "Calcium", "Magnésium", "Fer"),
      Question("Comment appelle-t-on une fracture où l’os traverse la peau ?", "Fracture fermée", "Fracture ouverte", "Fracture comminutive", "Fracture incomplète", "Fracture ouverte"),
      Question("Quel est le test principal pour diagnostiquer une infection pulmonaire ?", "IRM", "Radiographie thoracique", "Scanner", "Échographie", "Radiographie thoracique"),
      Question("Quel organe est responsable de la régulation des niveaux de sucre dans le sang ?", "Foie", "Pancréas", "Reins", "Cerveau", "Pancréas"),
      Question("Quel est le nom de l'hormone régulant les niveaux de sucre dans le sang ?", "Insuline", "Adrénaline", "Thyroxine", "Testostérone", "Insuline"),
      Question("Quel est le traitement préventif contre la variole ?", "Antibiotique", "Vaccination", "Antiviral", "Repose", "Vaccination"),
      Question("Quelle maladie pulmonaire est causée par une exposition à long terme à des irritants ?", "Asthme", "Bronchite chronique", "Pneumonie", "Emphysème", "Bronchite chronique"),
      Question("Quel est le nom scientifique de la maladie des os fragiles ?", "Ostéoporose", "Arthrose", "Scoliose", "Fibromyalgie", "Ostéoporose"),
      Question("Comment s'appelle l'évaluation de l'activité électrique du cœur ?", "Échocardiogramme", "Électrocardiogramme", "Scanner", "IRM", "Électrocardiogramme"),
      Question("Quel est le principal minéral nécessaire à la formation des os ?", "Phosphore", "Fer", "Calcium", "Sodium", "Calcium"),
      Question("Quel vaccin protège contre le tétanos ?", "DTaP", "MMR", "BCG", "Polio", "DTaP"),
      Question("Quel est le nom du processus par lequel le corps élimine les toxines par le foie ?", "Métabolisme", "Désintoxication", "Filtration", "Élimination", "Désintoxication"),
      Question("Quelle partie du cerveau est responsable de la mémoire ?", "Cervelet", "Hippocampe", "Hypothalamus", "Thalamus", "Hippocampe"),
    ];
    _questionBank.shuffle(); // Mélanger les questions

    _questionsLoaded = true;
  }

  Question getQuestion() {
    return _questionBank[_questionNum];
  }

  int getQuestionNumber() {
    return _questionNum + 1;
  }

  // Passer à la prochaine question en s'assurant qu'elle soit différente de la précédente
  void nextQuestion() {
    _previousQuestionNum = _questionNum; // Sauvegarder la question précédente

    if (_questionBank.length > 1) {
      do {
        _questionNum = Random().nextInt(_questionBank.length);
      } while (_questionNum == _previousQuestionNum);
    }
  }

  // Réinitialisation du quiz
  void reset() {
    _questionNum = 0;
    _previousQuestionNum = -1; // Réinitialiser la question précédente
    _fiftyFiftyUsed = false;
    _seventyFiveTwentyFiveUsed = false;
    _questionBank.shuffle(); // Re-mélanger les questions lors du reset
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

      if (options.isNotEmpty) {
        remainingOptions.add(options[Random().nextInt(options.length)]);
      }

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
      options.removeAt(correctAnswerIndex);

      // Supprimer deux mauvaises réponses aléatoirement
      if (options.length >= 2) {
        options.removeAt(Random().nextInt(options.length));
      }

      options.insert(0, getQuestion().answer); // Ajoute la réponse correcte
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
