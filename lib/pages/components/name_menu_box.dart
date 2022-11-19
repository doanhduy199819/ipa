import 'package:flutter/material.dart';

class NameBoxWidget extends StatefulWidget {
  const NameBoxWidget({
    Key? key,
    required this.string,
    required this.context,
  }) : super(key: key);
  final String string;
  final BuildContext context;

  @override
  State<StatefulWidget> createState() => _NameBoxWidgetState();
}

class _NameBoxWidgetState extends State<NameBoxWidget> {
  final _controller = TextEditingController();
  // final ValueChanged<String> onSubmit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ))),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: (() {}),
        child: Row(
          children: [
            Icon(Icons.person),
            const SizedBox(
              width: 20,
            ),
            Text(widget.string),
            const Spacer(),
            InkWell(
              child: Icon(
                Icons.edit,
                size: 16,
                color: Colors.grey,
              ),
              onTap: (() => _buildEdit(widget.string)),
            ),
          ],
        ),
      ),
    );
  }

  Future _buildEdit(String str) => showDialog(
      context: widget.context,
      builder: ((context) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  //upload date len firebase
                  Navigator.of(context).pop();
                },
                child: Text('Change'))
          ],
          title: Text('Change your name'),
          content: Container(
            height: 60,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "$str",
                  ),
                  controller: _controller,
                  onChanged: (Text) {
                    setState(() {
                      //do something
                      str = Text;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }));
}

class EmailBoxWidget extends StatelessWidget {
  const EmailBoxWidget({Key? key, required this.string}) : super(key: key);
  final String string;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ))),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: (() {}),
        child: Row(
          children: [
            Icon(Icons.mail),
            const SizedBox(
              width: 20,
            ),
            Text(this.string),
          ],
        ),
      ),
    );
  }
}
