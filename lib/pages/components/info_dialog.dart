import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoAlertDialog extends StatefulWidget {
  const InfoAlertDialog(
      {Key? key,
      required this.title,
      required this.handleInputValue,
      this.initialInputValue,
      this.hint})
      : super(key: key);

  final String title;
  final String? initialInputValue;
  final String? hint;
  final Function(String) handleInputValue;

  @override
  State<InfoAlertDialog> createState() => _InfoAlertDialogState();
}

class _InfoAlertDialogState extends State<InfoAlertDialog> {
  late String inputValue;

  @override
  void initState() {
    // TODO: implement initState
    inputValue = widget.initialInputValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.handleInputValue(inputValue);
          },
          child: const Text('Save'),
        ),
      ],
      content: TextFormField(
        initialValue: inputValue,
        onChanged: (val) => inputValue = val,
      ),
    );
  }
}
