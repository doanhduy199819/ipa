// import 'package:flutter/material.dart';
// import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
// import 'package:intl/intl.dart';
//
// class CompanyBloc extends StatelessWidget {
//   final String? urlImage;
//   const CompanyBloc({Key? key, required this.urlImage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 80,
//       // height: 80,
//       child: Image.asset(
//         urlImage ?? HomeScreenAssets.lgLogo,
//         fit: BoxFit.cover,
//       ),
//     );
//     // return Image.asset(
//     //   urlImage ?? HomeScreenAssets.lgLogo,
//     //   fit: BoxFit.fitHeight,
//     // );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:intl/intl.dart';

import '../../../../services/database_service.dart';

class CompanyBloc extends StatefulWidget {
  late String? idCompany;
  CompanyBloc({Key? key, required this.idCompany}) : super(key: key);

  @override
  State<CompanyBloc> createState() => _CompanyBlocState();
}

String errorImg =
    'https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-1932.jpg?w=2000';

class _CompanyBlocState extends State<CompanyBloc> {
  late String? urlImg;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getACompany(widget.idCompany),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong :(');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        urlImg = snapshot.data! as String?;
        return SizedBox(
          width: 80,
          // height: 80,
          child: Image.network(
            urlImg!,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.asset('assets/images/LG_logo.jpg');
            },
          ),
        );
      },
    );
    // return SizedBox(
    //   width: 80,
    //   // height: 80,
    //   child: Image.asset(
    //     urlImage ?? HomeScreenAssets.lgLogo,
    //     //urlImage ?? 'assets/images/fujitsu_is.png',
    //     fit: BoxFit.cover,
    //   ),
    // );
    // return Image.asset(
    //   urlImage ?? HomeScreenAssets.lgLogo,
    //   fit: BoxFit.fitHeight,
    // );
  }
}