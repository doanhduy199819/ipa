import 'package:flutter_interview_preparation/objects/Account.dart';

class Comment{
  int? upvote;
  bool? answerAccepted;
  String? content;
  String? timeComment;
  Account? account;
  Comment(this.upvote,this.answerAccepted,this.content,this.timeComment,this.account);
}
List<Comment> listComment=[
  Comment(50, true, 'Sau tat ca minh lai tro ve voi nhau', 'answered Dec 15 2021 at 13:45', listAccount[1]),
  Comment(12, false, 'Nang vuong tren canh hong kho nhung ki niem xua kia', 'answered Dec 15 2021 at 13:45', listAccount[0]),
  Comment(12, false, 'Chieu mua ben hien vang buon', 'answered Dec 15 2021 at 13:45', listAccount[0]),
  Comment(12, false, 'Dieu anh luon giu kin trong tim', 'answered Dec 15 2021 at 13:45', listAccount[0]),
  Comment(12, false, 'Teo teo teo teo teo teo teo teo teo teo teo teo', 'answered Dec 15 2021 at 13:45', listAccount[0]),
];