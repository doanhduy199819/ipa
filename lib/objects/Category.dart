import 'package:flutter_interview_preparation/objects/Chapter.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Assets.dart';

class Category{
  String? title;
  List<Chapter>? chapters;
  String? imagePath;
  Category(this.title,this.chapters,this.imagePath);
}

List<Category> listCategory=[
  Category('Algorithm0', listChapter, QuizScreenAssets.img_Algorithm),
  Category('Data Structure', listChapter, QuizScreenAssets.img_DataStructure),
  Category('Language', listChapter, QuizScreenAssets.img_Language),
  Category('Algorithm3', listChapter, QuizScreenAssets.img_Algorithm),
];