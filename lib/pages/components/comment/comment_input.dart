import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../objects/UserBlocked.dart';
import '../../../services/auth_service.dart';

class CommentInput extends StatefulWidget {
  const CommentInput(
      {Key? key, required this.onSendButtonPressed, this.scrollController})
      : super(key: key);

  final void Function(String) onSendButtonPressed;
  final ScrollController? scrollController;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  final _commentFocusNode = FocusNode();
  late String content;
  late Future<List<UserBlocked>?> _userBlockedFuture;

  @override
  void initState() {
    // TODO: implement initState
    content = '';
    FirebaseFirestore _db = FirebaseFirestore.instance;

    _userBlockedFuture = _db
        .collection('userwasblocked')
        .get()
        .then(_userBlockedsFromQuerySnapshot);
    super.initState();
  }

  List<UserBlocked>? _userBlockedsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        print('exits');
        return UserBlocked.fromDocumentSnapshot(documentSnapshot);
      }
      return UserBlocked.test();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _textFieldController,
            focusNode: _commentFocusNode,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Comment here!',
            ),
            validator: (value) {
              if (value == null || value.length < 1) {
                return 'Nothing to comment';
              }
            },
            onChanged: (value) => content = value,
            autofocus: false,
            scrollPadding: EdgeInsets.only(bottom: 8 + 64),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            FlatButton(
              // ignore: sort_child_properties_last
              child: const Text(
                'Send',
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () async {
                var usersblocked = await _userBlockedFuture;
                for (int i = 0; i < usersblocked!.length; i++) {
                  if (usersblocked[i].id_user ==
                      AuthService().currentUser!.uid) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: const Text('Ban'),
                            content: const Center(
                              child: Text('User was banned'),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Return"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        });

                    return;
                  }
                }

                widget.onSendButtonPressed(content);
                _clearCommentContent();
                _scrollDownToEndList();
              },
            ),
          ],
        )
      ],
    );
  }

  // Clear commentInput
  void _clearCommentContent() {
    _textFieldController.clear();
  }

  void _scrollDownToEndList() {
    // Move down to the end of screen
    final _controller = widget.scrollController;
    if (_controller == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      }
    });
  }
}
