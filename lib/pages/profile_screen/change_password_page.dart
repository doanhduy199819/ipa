import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String newPassword;
  late String oldPassword;
  late String confirmPass;
  // late String currentPass;
  late final TextEditingController _newPassController = TextEditingController();
  late final TextEditingController _confirmNewPassController =
      TextEditingController();
  late final TextEditingController _currentPassController =
      TextEditingController();
  bool checkCurrentPasswordValid = true;
  final _formStateKey = GlobalKey<FormState>();

  void initData() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: HomeScreenFonts.headStyle,
        ),
      ),
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Form(
        key: _formStateKey,
        child: Column(
          children: [
            _buildText('Enter your current password'),
            TextFormField(
              onChanged: (value) => setState(() => oldPassword = value),
              controller: _currentPassController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Current password',
                errorText:
                    checkCurrentPasswordValid ? null : "Incorrect password",
              ),
              style: HomeScreenFonts.description,
            ),
            _buildText('Enter new password'),
            TextFormField(
              controller: _newPassController,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Password must contain at least 8 characters';
                }
                return null;
              },
              onChanged: (value) => setState(() => newPassword = value),
              obscureText: true,
              decoration: inputDecoration('New password'),
              style: HomeScreenFonts.description,
            ),
            _buildText('Enter new password again'),
            TextFormField(
              validator: (value) {
                if (value != newPassword) {
                  return 'Your passwords does not match';
                }
                return null;
              },
              obscureText: true,
              decoration: inputDecoration('Confirm new password'),
              style: HomeScreenFonts.description,
            ),
            //
            //
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    if (_formStateKey.currentState!.validate()) {
                      AuthService _auth = AuthService();
                      AuthCredential credential = EmailAuthProvider.credential(
                          email: _auth.currentUser?.email ?? '',
                          password: oldPassword);

                      try {
                        await _auth.currentUser
                            ?.reauthenticateWithCredential(credential)
                            .then((newUserCredential) {
                          _auth.currentUser?.updatePassword(newPassword);
                          debugPrint('wrighttttttttttttt pass');

                          Fluttertoast.showToast(
                              msg: 'Password succesfully changed');
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          setState(() {
                            checkCurrentPasswordValid = false;
                            debugPrint('wrong pass');
                          });
                        }
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue.shade200),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Change',
                      style: HomeScreenFonts.title,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String text) {
    return InputDecoration(
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      labelText: text,
    );
  }

  Widget _buildText(String string) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            string,
            style: HomeScreenFonts.title,
          )
        ],
      ),
    );
  }

  void _showSnackBarAction(BuildContext context, String string, String notice) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(string),
        action: SnackBarAction(
            label: notice, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  
}
