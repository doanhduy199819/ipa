import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/question_controller.dart';

class RecentlyQuiz {
  String? id;
  String? jobId;
  String? categoriesId;
  String? quizId;
  String? quizName;
  int? highScore;
  RecentlyQuiz(
      {this.id,
      this.jobId,
      this.categoriesId,
      this.quizId,
      this.quizName,
      this.highScore});
  factory RecentlyQuiz.fromJson(Map<String, dynamic>? data) {
    String jobId = data?['jobid'];
    String categoriesId = data?['categoriesid'];
    String quizId = data?['quizid'];
    String quizName = data?['quizname'];
    int highScore = data?['highscore'];
    return RecentlyQuiz(
        jobId: jobId,
        categoriesId: categoriesId,
        quizId: quizId,
        quizName: quizName,
        highScore: highScore);
  }
  factory RecentlyQuiz.createdNow() {
    String jobId = QuesionController.dataBoxCategories.jobid.toString();
    String categoriesId =
        QuesionController.dataBoxCategories.categoriesid.toString();
    String quizId = QuesionController.setOfQuiz.id.toString();
    String quizName = QuesionController.setOfQuiz.name.toString();
    int highScore = QuesionController().getScoreQuiz();
    return RecentlyQuiz(
        jobId: jobId,
        categoriesId: categoriesId,
        quizId: quizId,
        quizName: quizName,
        highScore: highScore);
  }

  Map<String, dynamic> toJson() {
    return {
      'jobid': jobId,
      'categoriesid': categoriesId,
      'quizid': quizId,
      'quizname': quizName,
      'highscore': highScore,
      'timecreated': Timestamp.now(),
    };
  }

  factory RecentlyQuiz.fromJsonWithID(Map<String, dynamic>? data, String id) {
    String jobId = data?['jobid'];
    String categoriesId = data?['categoriesid'];
    String quizId = data?['quizid'];
    String quizName = data?['quizname'];
    int highScore = data?['highscore'];
    return RecentlyQuiz(
      id: id,
      jobId: jobId,
      categoriesId: categoriesId,
      quizId: quizId,
      quizName: quizName,
      highScore: highScore,
    );
  }
}
