class Question {

 String questionText;
 String option1;
 String option2;
 String option3;
 String option4;
 String answer;

 Question(this.questionText,this.option1,this.option2,this.option3,this.option4,this.answer);

 factory Question.fromJson (Map<String, dynamic> json) {
  return Question(json['question'],json['option1'],json['option2'],json['option3'],json['option4'],json['answer']);
 }

}