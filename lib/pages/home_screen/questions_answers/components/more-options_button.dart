import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../../objects/CommentReport.dart';


// class MoreOptionsDropDownButton extends StatelessWidget {
//   const MoreOptionsDropDownButton(
//       {Key? key, required this.comment, required this.onDelete,required this.idQuestion})
//       : super(key: key);
//
//   // List<Widget> childrenNotIncludingCancel;
//   final Comment comment;
//   final Function() onDelete;
//   final String idQuestion;
//   // final String questionId;
//
//   Text contentReportInkWell(String content) {
//     return Text(
//       content,
//       style: const TextStyle(
//         fontSize: 15,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton<String>(
//         icon: Visibility(visible: true, child: Icon(Icons.more_horiz_rounded)),
//         items: [
//           if (comment.author_id == AuthService().currentUserId) ...[
//             DropdownMenuItem(
//               value: 'delete',
//               child: Text('Delete'),
//             ),
//           ],
//           DropdownMenuItem(
//             value: 'report',
//             child: Text('Report'),
//           ),
//         ],
//         onChanged: ((value) {
//           if (value == 'report') {
//             bool isClicked = false;
//             int selectedLocation = -1;
//             String report_type='';
//             showDialog(
//               context: context,
//               builder: (context) {
//                 String contentText = "Content of Dialog";
//                 return StatefulBuilder(
//                   builder: (context, setState) {
//                     print('isClick $isClicked');
//                     return AlertDialog(
//                       title: const Text("Content Of Report"),
//                       content: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Form(
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: (selectedLocation == 0)
//                                           ? const Color.fromARGB(255, 142, 142, 145)
//                                           : Colors.white,
//                                     ),
//                                     child: InkWell(
//                                       child: contentReportInkWell(
//                                           'Improper Words'),
//                                       onTap: () {
//                                         setState(() {
//                                           isClicked = true;
//                                           selectedLocation = 0;
//                                           report_type='Improper Words';
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//
//                                     decoration: BoxDecoration(
//                                       color: (selectedLocation == 1)
//                                           ? const Color.fromARGB(255, 142, 142, 145)
//                                           : Colors.white,
//                                     ),
//                                     child: InkWell(
//                                       child: contentReportInkWell('Spam'),
//                                       onTap: () {
//                                         setState(() {
//                                           isClicked = true;
//                                           selectedLocation = 1;
//                                           report_type='Spam';
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: (selectedLocation == 2)
//                                           ? const Color.fromARGB(255, 142, 142, 145)
//                                           : Colors.white,
//                                     ),
//                                     child: InkWell(
//                                       child:
//                                       contentReportInkWell('Hate Speech'),
//                                       onTap: () {
//                                         setState(() {
//                                           isClicked = true;
//                                           selectedLocation = 2;
//                                           report_type='Hate Speech';
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 12,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: (selectedLocation == 3)
//                                           ? const Color.fromARGB(255, 142, 142, 145)
//                                           : Colors.white,
//                                     ),
//                                     child: InkWell(
//                                       child: contentReportInkWell('Orther'),
//                                       onTap: () {
//                                         setState(() {
//                                           isClicked = true;
//                                           selectedLocation = 3;
//                                           report_type='Orther';
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text("Cancel"),
//                         ),
//                         (isClicked == true)
//                             ? TextButton(
//                           onPressed: () {
//                             CommentReport commentReport=CommentReport(
//                                 null,
//                                 idQuestion,
//                                 comment.author_id,
//                                 null,
//                                 comment.content,
//                                 comment.id,
//                                 report_type);
//                             DatabaseService().addCommentReport(commentReport);
//                             Navigator.pop(context);
//                           },
//                           child: Text("Send"),
//                         )
//                             : Container(),
//                       ],
//                     );
//                   },
//                 );
//               },
//             );
//           } else if (value == 'edit') {
//           } else if (value == 'delete') {
//             showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: Text('Delete?'),
//                   content:
//                   Text('Are you sure want to delete this comment?'),
//                   actions: [
//                     FlatButton(
//                         onPressed: () {
//                           _dissmissAlertDialog(context);
//                         },
//                         child: Text('No')),
//                     FlatButton(
//                       onPressed: () {
//                         _dissmissAlertDialog(context);
//                         onDelete();
//                       },
//                       child: Text(
//                         'Yes',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ],
//                 ),
//                 barrierDismissible: true);
//           }
//         }),
//       ),
//     );
//   }
//
//   void _dissmissAlertDialog(BuildContext context) {
//     Navigator.of(context, rootNavigator: true).pop();
//   }
// }
class MoreOptionsDropDownButton extends StatelessWidget {
  const MoreOptionsDropDownButton(
      {Key? key, required this.comment, required this.onDelete,required this.idQuestion, required this.screen })
      : super(key: key);

  // List<Widget> childrenNotIncludingCancel;
  final Comment comment;
  final Function() onDelete;
  final String idQuestion;
  final String screen;
  // final String questionId;

  Text contentReportInkWell(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Visibility(visible: true, child: Icon(Icons.more_horiz_rounded)),
        items: [
          if (comment.author_id == AuthService().currentUserId) ...[
            DropdownMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          DropdownMenuItem(
            value: 'report',
            child: Text('Report'),
          ),
        ],
        onChanged: ((value) {
          if (value == 'report') {
            bool isClicked = false;
            int selectedLocation = -1;
            String report_type='';
            showDialog(
              context: context,
              builder: (context) {
                String contentText = "Content of Dialog";
                return StatefulBuilder(
                  builder: (context, setState) {
                    print('isClick $isClicked');
                    return AlertDialog(
                      title: const Text("Content Of Report"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: (selectedLocation == 0)
                                          ? const Color.fromARGB(255, 142, 142, 145)
                                          : Colors.white,
                                    ),
                                    child: InkWell(
                                      child: contentReportInkWell(
                                          'Improper Words'),
                                      onTap: () {
                                        setState(() {
                                          isClicked = true;
                                          selectedLocation = 0;
                                          report_type='Improper Words';
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(

                                    decoration: BoxDecoration(
                                      color: (selectedLocation == 1)
                                          ? const Color.fromARGB(255, 142, 142, 145)
                                          : Colors.white,
                                    ),
                                    child: InkWell(
                                      child: contentReportInkWell('Spam'),
                                      onTap: () {
                                        setState(() {
                                          isClicked = true;
                                          selectedLocation = 1;
                                          report_type='Spam';
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: (selectedLocation == 2)
                                          ? const Color.fromARGB(255, 142, 142, 145)
                                          : Colors.white,
                                    ),
                                    child: InkWell(
                                      child:
                                      contentReportInkWell('Hate Speech'),
                                      onTap: () {
                                        setState(() {
                                          isClicked = true;
                                          selectedLocation = 2;
                                          report_type='Hate Speech';
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: (selectedLocation == 3)
                                          ? const Color.fromARGB(255, 142, 142, 145)
                                          : Colors.white,
                                    ),
                                    child: InkWell(
                                      child: contentReportInkWell('Orther'),
                                      onTap: () {
                                        setState(() {
                                          isClicked = true;
                                          selectedLocation = 3;
                                          report_type='Orther';
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        (isClicked == true)
                            ? TextButton(
                          onPressed: () {
                            CommentReport commentReport=CommentReport(
                                null,
                                idQuestion,
                                comment.author_id,
                                null,
                                comment.content,
                                comment.id,
                                report_type,
                                screen);
                            DatabaseService().addCommentReport(commentReport);
                            Navigator.pop(context);
                          },
                          child: Text("Send"),
                        )
                            : Container(),
                      ],
                    );
                  },
                );
              },
            );
          } else if (value == 'edit') {
          } else if (value == 'delete') {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Delete?'),
                  content:
                  Text('Are you sure want to delete this comment?'),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          _dissmissAlertDialog(context);
                        },
                        child: Text('No')),
                    FlatButton(
                      onPressed: () {
                        _dissmissAlertDialog(context);
                        onDelete();
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                barrierDismissible: true);
          }
        }),
      ),
    );
  }

  void _dissmissAlertDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

