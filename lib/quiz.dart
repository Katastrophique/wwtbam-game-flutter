import 'question.dart';
class Quiz
{
  int _questionNum = 0;
  List<Question> _questionBank = [
  Question("Which of the following is the least dense planet among all the planets?","Earth","Uranus","Jupiter","Saturn","Saturn"),
  Question("Petrology is the study of","Soils","Rocks","Oceans","Mountains","Rocks"),
  Question("In which year the Jnanpith Award was first awarded?","1965","1955","1972","None of these","1965"),
  Question("Who received the first Jnanpith award?","G. Sankara Kurup","Krishna Sobti","Ashapoorna Devi","None of these","G. Sankara Kurup"),
  Question("For Which book did VS Naipaul got Nobel Prize?","A House for Mr Biswas","Miguel Street","In a Free State","None of these","In a Free State"),

  Question("What was the original name of renowned Hindi and Urdu writer Munshi Premchand?","Prem Das","Dhanpat Rai","Khwaja Ahmed","None of these","Dhanpat Rai"),
  Question("Which one is the first novel of Chetan Bhagat?","One Night @ the Call Center","The 3 Mistakes Of My Life","Five Point Someone","None of these","Five Point Someone"),
  Question("Who is the writer of of the book ‘Train to Pakistan’?","Amrita Pritam","Khushwant Singh","R. K. Narayan","None of these","Khushwant Singh"),
  Question("Who is the author of the novel ‘The Inheritance of Loss’?","Amitav Ghosh","Arundhati Roy","Kiran Desai","None of these","Kiran Desai"),
  Question("Who was the first women to received Jnanpith Award?","Anita Desai","Krishna Sobti","Ashapoorna Devi","None of these","Ashapoorna Devi"),

  Question("Who was the writer of the book ‘Devdas’?","Saratchandra Chattopadhyay","Bankim Chandra Chattopadhyay","Mulk Raj Anand","None of these","Saratchandra Chattopadhyay"),
  Question("Who is author of the novel of ‘A suitable boy’?","Salman Rushdie","Rohinton Mistry","Vikram Seth","None of these","Vikram Seth"),
  Question("Who is the writer of ‘Malgudi Days’?","Mulk Raj Anand","R. K. Narayan","R. K. Laxman","None of these","R. K. Narayan"),
  Question("Who was the first Indian to win Man Booker?","Salman Rushdie","Arundhati Roy","Kiran Desai","None of these","Arundhati Roy"),
  Question("Who won the Pulitzer Prize in India?","Jhumpa Lahiri","Gobind Behari Lal","Amit Chaudhuri","None of these","Gobind Behari Lal"),
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
}
