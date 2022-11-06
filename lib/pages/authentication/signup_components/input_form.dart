import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget(
      {Key? key,
      this.iconData,
      this.mainColor,
      this.hintText,
      this.hintTextColor,
      this.onChanged,
      this.validator,
      this.textColor,
      this.onEditingComplete})
      : super(key: key);

  final IconData? iconData;
  final Color? mainColor;
  final String? hintText;
  final Color? hintTextColor;
  final Color? textColor;
  final dynamic Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final Color defaultColor = const Color.fromARGB(255, 24, 15, 92);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      padding: EdgeInsets.only(left: 16.0, right: 8.0),
      decoration: BoxDecoration(
          color: Colors.white70.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(width: 2.0, color: mainColor ?? defaultColor)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(iconData, color: mainColor),
            hintText: hintText,
            hintStyle: TextStyle(color: hintTextColor ?? Colors.grey),
            contentPadding: const EdgeInsets.all(16.0),
            border: InputBorder.none,
          ),
          style: TextStyle(color: textColor),
          onChanged: onChanged,
          validator: validator,
          onEditingComplete: onEditingComplete,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }
}
