// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
// import 'package:flutter_interview_preparation/services/database_service.dart';

// import '../../../objects/Categories.dart';
// import '../../../objects/Job.dart';

// class JobController {
//   static List<Job>? database = [];
//   static List<DataBoxCategories> dataBoxCategories = [];

//   void add() {
//     print("\n\n\n Start add");
//     database = [];
//     database = DatabaseService().allJobOnce as List<Job>?;
//     database?.forEach((element) {
//       List<Categories>? listCategories = [];
//       listCategories =
//           DatabaseService().allCategoriesOnce(element.id!) as List<Categories>?;
//       element.categories = listCategories;
//       print("id: ${element.id}, name: ${element.name},categories:[");
//       element.categories?.forEach((element) {
//         print("{id: ${element.id}, name: ${element.name}}");
//       });
//       print("]");
//     });
//     print("End add\n\n\n");
//   }

//   void printConsole() {
//     print("\n\n\n Start print");
//     database!.forEach((element) {
//       print("id1: ${element.id}, name1: ${element.name},categories1:[");
//       element.categories?.forEach((element) {
//         print("{id1: ${element.id}, name1: ${element.name}}");
//       });
//       print("]");
//     });
//     print("End print\n\n\n");
//   }

//   List<DataBoxCategories> getDataBoxCategories() {
//     List<DataBoxCategories> result = [];
//     database?.forEach((job) {
//       String? specialized = job.name;
//       job.categories?.forEach((categories) {
//         result.add(
//             DataBoxCategories(specialized: specialized, name: categories.name));
//       });
//     });
//     return result;
//   }
// }
