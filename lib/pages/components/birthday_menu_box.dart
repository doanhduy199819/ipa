import 'package:flutter/material.dart';
class BirthDayBoxWidget extends StatefulWidget {
  const BirthDayBoxWidget({
    Key? key,
    required this.string,
    required this.context,
  }) : super(key: key);
  final String string;
  final BuildContext context;

  @override
  State<StatefulWidget> createState() => _BirthDayBoxWidgetState();
}

class _BirthDayBoxWidgetState extends State<BirthDayBoxWidget> {
  late final DateTime dateTime;
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
            Icon(Icons.calendar_month),
            const SizedBox(
              width: 20,
            ),
            Text(widget.string),
            const Spacer(),
            InkWell(
              child: Icon(
                Icons.edit_calendar,
                size: 16,
                color: Colors.grey,
              ),
              onTap: (() async {
                final date = await pickDay(context);
                if (date == null) return; //pressed Cancel button
                setState(() {
                  //do something
                  dateTime = date;
                });
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> pickDay(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now());
}
