import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Category.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

class TitleTagContentQABloc extends StatelessWidget {
  String? title;
  List<String>? category;
  String? content;
  String? urlImageCompany = HomeScreenAssets.lgLogo;
  final bool isShowingDetails;
  TitleTagContentQABloc(
      {Key? key,
      required this.title,
      required this.category,
      required this.content,
      this.urlImageCompany,
      this.isShowingDetails = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          // width: MediaQuery.of(context).size.width * 12 / 15 - 15,
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: title,
                style: HomeScreenFonts.title
                    .copyWith(fontSize: !isShowingDetails ? 12 : 16)),
          ),
        ),

        // Tags
        Row(
          children: [
            // Gioi han Tag lai
            for (int i = 0; i < (category?.length ?? 0); i++)
              if (i < 3)
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4, bottom: 6.0, right: 4.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: const Color(0xffDFE2EB),
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        text: category![i],
                        style: !isShowingDetails
                            ? HomeScreenFonts.interestTag
                            : HomeScreenFonts.interestTag
                                .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                )
          ],
        ),
        Container(
          // width: MediaQuery.of(context).size.width * 4 / 7,
          padding: const EdgeInsets.only(bottom: 4),
          child: RichText(
            maxLines: !isShowingDetails ? 1 : null,
            overflow: !isShowingDetails
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
            text: TextSpan(
              text: content ?? 'Something went wrong',
              style: !isShowingDetails
                  ? HomeScreenFonts.content
                  : HomeScreenFonts.content.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
