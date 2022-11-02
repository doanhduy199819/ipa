import 'package:flutter/material.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.hideText,
    this.mainColor = const Color.fromARGB(255, 96, 34, 1),
  }) : super(key: key);

  final String? hintText;
  final Icon? prefixIcon;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool? hideText;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    var outlinedBox = BoxDecoration(
      borderRadius: BorderRadius.all(const Radius.circular(6.0)),
      border: Border.all(width: 1.0, color: mainColor),
      color: Colors.white,
    );

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: outlinedBox,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon?.icon ?? Icons.abc, color: mainColor),
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16.0),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
