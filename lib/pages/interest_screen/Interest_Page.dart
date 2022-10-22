// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_interview_preparation/main.dart';
// import 'package:flutter_interview_preparation/objects/Interest.dart';
// import 'package:flutter_interview_preparation/pages/interest_screen/Custom_Interest_Bloc.dart';
// import 'package:flutter_interview_preparation/values/Interest_Screen_Fonts.dart';

// class InterestWidget extends StatefulWidget {
//   const InterestWidget({Key? key}) : super(key: key);

//   @override
//   State<InterestWidget> createState() => _InterestWidgetState();
// }

// class _InterestWidgetState extends State<InterestWidget> {
//   final List<Interest> myInterest = [];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: SafeArea(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: const Color(0xff3AB6FF),
//             child: Column(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   margin: const EdgeInsets.only(top: 35),
//                   width: MediaQuery.of(context).size.width * 73 / 100,
//                   height: MediaQuery.of(context).size.height * 11 / 100,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white, width: 0.5),
//                   ),
//                   child: Text(
//                     'Choose your interest',
//                     style: InterestFont.chooseInterest,
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   margin: const EdgeInsets.only(top: 35),
//                   width: MediaQuery.of(context).size.width * 73 / 100,
//                   height: MediaQuery.of(context).size.height * 11 / 100,
//                   decoration: const BoxDecoration(
//                     border: Border(
//                         top: BorderSide(
//                       color: Colors.white,
//                       width: 0.5,
//                     )),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 78 / 100,
//                   height: MediaQuery.of(context).size.height * 54 / 100,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         // Topic bloc
//                         for (int i = 0; i < listInterest.length; i++)
//                           if (i % 2 == 0 && i < listInterest.length - 1)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 interestBloc(listInterest[i],
//                                     MediaQuery.of(context).size.width),
//                                 interestBloc(listInterest[i + 1],
//                                     MediaQuery.of(context).size.width),
//                                 // CustomInterestBloc(
//                                 //   interest: listInterest[i+1],
//                                 //   widthOfDevice:MediaQuery.of(context).size.width,
//                                 //   isClicked: interestsValue[i % 2],
//                                 //     onTap: () {
//                                 //       setState(() {
//                                 //         interestsValue[i % 2] =
//                                 //             !interestsValue[i % 2];
//                                 //       });
//                                 //     },
//                                 // ),
//                               ],
//                             )
//                           else if (i % 2 == 0 && i == listInterest.length - 1)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 interestBloc(listInterest[i],
//                                     MediaQuery.of(context).size.width),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width /
//                                       10 *
//                                       3.5,
//                                   height: MediaQuery.of(context).size.width /
//                                       10 *
//                                       3.7,
//                                 ),
//                                 // InkWell(
//                                 //   child: CustomInterestBloc(
//                                 //     interest: listInterest[i],
//                                 //     isClicked: interestsValue[i % 2],
//                                 //     onTap: () {
//                                 //       setState(() {
//                                 //         interestsValue[i % 2] =
//                                 //             !interestsValue[i % 2];
//                                 //       });
//                                 //     },
//                                 //     widthOfDevice: MediaQuery.of(context).size.width,
//                                 //   ),
//                                 // ),
//                               ],
//                             )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(right: 20),
//                       child: InkWell(
//                         child: Text(
//                           'Next',
//                           style: InterestFont.chooseInterest
//                               .copyWith(decoration: TextDecoration.underline),
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               fullscreenDialog: false,
//                               builder: (context) =>
//                                   const MyHomePage(title: 'IPA Flutter'),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget interestBloc(Interest interest, double widthOfDevice) {
//     return InkWell(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: (checkContainInterest(interest) == -1)
//                   ? Colors.white
//                   : const Color(0xff2041F4),
//               borderRadius: BorderRadius.circular(50),
//             ),
//             alignment: Alignment.center,
//             width: widthOfDevice * 35 / 100,
//             height: widthOfDevice * 14 / 100,
//             child: Text(
//               '${interest.title}',
//               style: InterestFont.fontInterestBloc,
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           )
//         ],
//       ),
//       onTap: () {
//         setState(() {
//           int vtCheck = checkContainInterest(interest);
//           if (vtCheck == -1) {
//             myInterest.add(interest);
//           } else {
//             myInterest.removeAt(vtCheck);
//           }
//         });
//       },
//     );
//   }

//   int checkContainInterest(Interest interest) {
//     for (int i = 0; i < myInterest.length; i++) {
//       if (myInterest[i].title!.compareTo(interest.title!) == 0) {
//         return i;
//       }
//     }
//     return -1;
//   }
// }
