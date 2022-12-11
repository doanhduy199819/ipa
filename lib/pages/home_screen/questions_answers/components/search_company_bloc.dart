import 'package:flutter/material.dart';
import '../../../../values/Home_Screen_Fonts.dart';

class SearchCompanyBloc extends StatelessWidget {
  double widthScreen;
  SearchCompanyBloc({Key? key, required this.widthScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return searchPart();
  }

  Widget searchPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'All Questions',
            style: HomeScreenFonts.h1
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 4,),
          Row(
            children: [
              const Spacer(),
              Text(
                'Company',
                style: HomeScreenFonts.h1
                    .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
          
              Container(
                width: widthScreen * 0.62,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xffEDEAEA),

                ),
                child: textFieldBloc(),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextField textFieldBloc() {
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),

        hintStyle: const TextStyle(fontSize: 12),
        hintText: 'Search Company',
        prefixIcon: const Icon(Icons.search, size: 17),
        prefixIconColor: Colors.purple.shade900,
      ),
    );
  }
}
