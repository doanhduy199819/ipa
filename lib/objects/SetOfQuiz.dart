// class Quiz{
//   String content;
//   List<String> listSuggest;
//   int correctAnswer;
//   String explanation;

//   Quiz(this.content,this.listSuggest,this.correctAnswer,this.explanation);
// }
// List<Quiz> listQuiz=[
// ];
class SetOfQuiz {
  String? id;
  String? name;
  SetOfQuiz({this.id, this.name});

  factory SetOfQuiz.fromJson(Map<String, dynamic>? data, String dataid) {
    String id = dataid;
    String name = data?['name'];
    return SetOfQuiz(id: id, name: name);
  }
}
