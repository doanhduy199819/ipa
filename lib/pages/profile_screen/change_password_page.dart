import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String newPassword;
  late String password;
  late String confirmPass;
  late String currentPass;
  late final TextEditingController _newPassController = TextEditingController();
  late final TextEditingController _confirmNewPassController =
      TextEditingController();
  late final TextEditingController _currentPassController =
      TextEditingController();
  void initData() {
    // _newPassController ;
    // _confirmNewPassController = TextEditingController();
    // _currentPassController = TextEditingController();
    currentPass = '12345678';
  }

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
    bool validate = true;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          _buildText('Enter new password'),
          TextFormField(
            controller: _newPassController,
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must contain at least 8 characters';
              }
              return null;
            },
            onChanged: (text) {
              newPassword = text;
            },
            obscureText: true,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            autocorrect: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: 'New password',
            ),
            style: HomeScreenFonts.description,
          ),
          _buildText('Enter new password again'),
          TextFormField(
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must contain at least 8 characters';
              }
              return null;
            },
          
            onChanged: (text) {
              confirmPass = text;
            },
            controller: _confirmNewPassController,
            keyboardType: TextInputType.text,
            obscureText: true,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              labelText: 'Confirm new password',
            ),
            style: HomeScreenFonts.description,
          ),
          _buildText('Enter your current password'),
          TextFormField(
            onChanged: (text) {
              password = text;
            },
            controller: _currentPassController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.none,
            obscureText: true,
            autocorrect: false,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                labelText: 'Current password'),
            style: HomeScreenFonts.description,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _buildButtonChange();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.blue.shade400,
                        width: 1,
                      )),
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

  void _buildButtonChange() {
    if (newPassword != confirmPass) {
      _showSnackBarAction(context, 'Confirm password incorrect', 'Try again');
      return;
    }
    if (password != currentPass) {
      _showSnackBarAction(context, 'Password incorrect', 'Try again');
      return;
    }
    _showSnackBarAction(context, 'Change successfull', 'OK');
    //do something
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
