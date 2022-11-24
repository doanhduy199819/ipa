import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/components/info_dialog.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NameBoxWidget extends StatefulWidget {
  const NameBoxWidget({
    Key? key,
    required this.userName,
    required this.context,
  }) : super(key: key);
  final String userName;
  final BuildContext context;

  @override
  State<StatefulWidget> createState() => _NameBoxWidgetState();
}

class _NameBoxWidgetState extends State<NameBoxWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
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
            Icon(Icons.person,
                color: Theme.of(context).scaffoldBackgroundColor),
            const SizedBox(
              width: 20,
            ),
            Text(widget.userName),
            const Spacer(),
            InkWell(
              child: Icon(Icons.edit,
                  size: 16, color: Theme.of(context).scaffoldBackgroundColor),
              onTap: (() => _buildEdit(widget.userName)),
            ),
          ],
        ),
      ),
    );
  }

  void _buildEdit(String oldName) async {
    // editNameDialog will show a dialog an then return the value
    // in textfield
    showDialog(
      context: context,
      builder: (_) => InfoAlertDialog(
        title: "Change display name",
        hint: oldName,
        initialInputValue: widget.userName,
        handleInputValue: (name) async {
          if (!await AuthService().isDisplayNameExist(name)) {
            AuthService().updateDisplayName(name);
          } else {
            // Already logged in
            Fluttertoast.showToast(msg: "Existing user name");
          }
        },
      ),
    );
  }
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
            Icon(Icons.mail, color: Theme.of(context).scaffoldBackgroundColor),
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
