import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Category.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

class TitleTagContentQABloc extends StatelessWidget {
  String? title;
  List<String>? category;
  String? content;
  String? urlImageCompany;
  TitleTagContentQABloc(
      {Key? key,
      required this.title,
      required this.category,
      required this.content,
      this.urlImageCompany})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title
        (urlImageCompany!.compareTo('') != 0)
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                width: MediaQuery.of(context).size.width * 12 / 15 - 15,
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: title,
                      // style: const TextStyle(
                      //   color: Colors.black,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      style: HomeScreenFonts.title.copyWith(fontSize: 12)),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                width: MediaQuery.of(context).size.width * 4 / 7,
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: title,
                    style: HomeScreenFonts.title.copyWith(fontSize: 12),
                  ),
                ),
              ),

        //Tags
        (category != null)
            ? Row(
                children: [
                  // Gioi han Tag lai
                  for (int i = 0; i < category!.length; i++)
                    if (i < 3)
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 6.0, right: 4.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          color: const Color(0xffDFE2EB),
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              text: category![i],
                              style: HomeScreenFonts.interestTag,
                            ),
                          ),
                        ),
                      )
                ],
              )
            : Row(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
        //Content
        (urlImageCompany!.compareTo('') != 0)
            ? Container(
                width: MediaQuery.of(context).size.width * 12 / 15 - 15,
                padding: const EdgeInsets.only(bottom: 4),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: content ?? 'Something went wrong',
                    style: HomeScreenFonts.content,
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 4 / 7,
                padding: const EdgeInsets.only(bottom: 4),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: content ?? 'Something went wrong',
                    style: HomeScreenFonts.content,
                  ),
                ),
              ),
      ],
    );
  }
}
