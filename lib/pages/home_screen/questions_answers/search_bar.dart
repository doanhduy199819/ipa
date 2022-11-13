import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
    const searchTextFieldDecoration = const InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      border: InputBorder.none,
      hintText: 'Search Company',
      isDense: true,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Top Questions',
            style: HomeScreenFonts.title.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: boxDecoration,
                child: TextField(
                  decoration: searchTextFieldDecoration,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Container(
              decoration: boxDecoration,
              padding: EdgeInsets.zero,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
                onPressed: () {},
                icon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
