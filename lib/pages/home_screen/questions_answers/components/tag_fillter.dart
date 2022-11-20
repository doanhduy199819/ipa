import 'package:flutter/material.dart';
import '../../../../values/Home_Screen_Fonts.dart';

class BuildTagFillter extends StatefulWidget {
  List<String>? fillters;
  int currentlyIndexFillters;
  final Function(int)? onIndexChange;

  BuildTagFillter(
      {Key? key,
      this.fillters,
      required this.currentlyIndexFillters,
      this.onIndexChange})
      : super(key: key);

  @override
  State<BuildTagFillter> createState() => _BuildTagCategoryState();
}

class _BuildTagCategoryState extends State<BuildTagFillter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _buildListFillters(),
    );
  }

  Widget _buildListFillters() {
    Widget tempWidget = (widget.fillters != null)
        ? ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            childrenDelegate:
                SliverChildBuilderDelegate(childCount: widget.fillters!.length,
                    (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.currentlyIndexFillters = index;
                  });
                  // This call when user tap at each filter
                  widget.onIndexChange != null
                      ? widget.onIndexChange!(index)
                      : null;
                },
                child: (widget.currentlyIndexFillters == index)
                    ? CategoryWidget(
                        index: index,
                        textColor: Colors.black,
                        categories: widget.fillters,
                        bgColor: const Color.fromARGB(255, 209, 204, 204),
                        currentlyIndexCategory: widget.currentlyIndexFillters,
                      )
                    : CategoryWidget(
                        index: index,
                        textColor: const Color.fromARGB(255, 102, 100, 100),
                        categories: widget.fillters,
                        bgColor: Colors.white,
                        currentlyIndexCategory: widget.currentlyIndexFillters,
                      ),
              );
            }),
          )
        : const SizedBox(
            height: 20,
          );
    return tempWidget;
  }

  Function onClickAtCategory(int index) {
    return () => {widget.currentlyIndexFillters = index};
  }
}

class CategoryWidget extends StatelessWidget {
  int index;
  List<String>? categories;
  Color textColor;
  Color bgColor;
  int currentlyIndexCategory;
  CategoryWidget(
      {Key? key,
      required this.index,
      required this.categories,
      required this.textColor,
      required this.bgColor,
      required this.currentlyIndexCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(width: 0.5),
          left: (index == 0)
              ? const BorderSide(
                  width: 0.5,
                )
              : const BorderSide(width: 0.25),
          right: (index == categories!.length - 1)
              ? const BorderSide(width: 0.5)
              : const BorderSide(width: 0.25),
          bottom: const BorderSide(width: 0.5),
        ),
        color: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            categories![index],
            style: HomeScreenFonts.titleQuestion.copyWith(
              fontSize: (currentlyIndexCategory == index) ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }
}
