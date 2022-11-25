import 'package:flutter_interview_preparation/objects/Chapter.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Assets.dart';

class Experience{
  String? title;
  List<Chapter>? chapters;
  String? imagePath;
  Experience(this.title,this.chapters,this.imagePath);
}

List<Experience> listExperience=[
  Experience('Algorithm0', listChapter, QuizScreenAssets.img_Algorithm),
  Experience('Data Structure', listChapter, QuizScreenAssets.img_DataStructure),
  Experience('Language', listChapter, QuizScreenAssets.img_Language),
  Experience('Algorithm3', listChapter, QuizScreenAssets.img_Algorithm),
];