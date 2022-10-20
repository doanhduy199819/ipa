class Quiz{
  String? content;
  List<String>? listSuggest;
  int? correctAnswer; 
  bool? isAnswer;
  Quiz(this.content,this.listSuggest,this.correctAnswer,this.isAnswer);
}
List<Quiz> listQuiz=[
Quiz('What is HTML', ['A','B','C','D'],0,true),
Quiz('What is HTML', ['A','B','C','D'],1,true),
Quiz('What is HTML', ['A','B','C','D'],2,true),
Quiz('What is HTML', ['A','B','C','D'],3,true),
Quiz('What is HTML', ['A','B','C','D'],1,false),
];