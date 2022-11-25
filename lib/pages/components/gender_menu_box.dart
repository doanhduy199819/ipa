import 'package:flutter/material.dart';

class GenderBoxWidget extends StatefulWidget {
  const GenderBoxWidget({
    Key? key,
    required this.gender,
    required this.context,
  }) : super(key: key);
  final int gender;
  final BuildContext context;

  @override
  State<StatefulWidget> createState() => _GenderBoxWidgetState();
}

class _GenderBoxWidgetState extends State<GenderBoxWidget> {
  int _genderCheck = 0; //Gender of user
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ))),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: (() {}),
        child: Row(
          children: [
            const Icon(Icons.male),
            const SizedBox(
              width: 20,
            ),
            Text(_buildGenderText(widget.gender)),
            const Spacer(),
            InkWell(
              onTap: (() {
                _buildChangeGender(widget.gender);
              }),
              child: const Icon(
                Icons.edit,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildGenderText(int gen) {
    return gen == 0 ? 'Male' : 'Female';
  }

  Future _buildChangeGender(int gen) => showDialog(
      context: widget.context,
      builder: ((context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    _genderCheck = 0;
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Change'))
            ],
            title: Text('Choose your Gender'),
            content: Container(
              height: 120,
              child: Column(children: <Widget>[
                ListTile(
                  title: const Text('Male'),
                  leading: Radio(
                    value: 0,
                    groupValue: _genderCheck,
                    onChanged: (value) {
                      setState(() {
                        _genderCheck = 0;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio(
                    value: 1,
                    groupValue: _genderCheck,
                    onChanged: (value) {
                      setState(() {
                        _genderCheck = 1;
                      });
                    },
                  ),
                ),
              ]),
            ));
      }));
}
