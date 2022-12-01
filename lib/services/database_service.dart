// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/SetOfQuiz.dart';
import 'package:flutter_interview_preparation/services/account_service.dart';
import 'package:flutter_interview_preparation/services/articles_service.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/categories_service.dart';
import 'package:flutter_interview_preparation/services/comment_service.dart';
import 'package:flutter_interview_preparation/services/company_service.dart';
import 'package:flutter_interview_preparation/services/qa_service.dart';
import 'package:flutter_interview_preparation/services/job_service.dart';
import 'package:flutter_interview_preparation/services/quiz_service.dart';
import 'package:flutter_interview_preparation/services/recently_quiz_service.dart';

import 'SetOfQuestion_service.dart';

class DatabaseService
    with
        ArticlePostHandle,
        QAService,
        CommentService,
        AccountService,
        JobService,
        CategoriesService,
        SetOfQuizService,
        QuizService,
        RecentlyQuizService,
        CompanyService {}
