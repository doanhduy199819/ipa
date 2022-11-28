import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    content = '';
    super.initState();
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
            Spacer(),
            FlatButton(
              child: Text(
                'Send',
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
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
