import 'package:flutter/material.dart';

class VoteBloc extends StatelessWidget {
  final int numberOfVotes;
  final int numberOfAnswers;
  const VoteBloc(
      {Key? key, required this.numberOfVotes, required this.numberOfAnswers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      width: MediaQuery.of(context).size.width * 1 / 7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vote
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                const Icon(Icons.arrow_upward),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    numberOfVotes.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          // Answer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                const Icon(Icons.comment),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    numberOfAnswers.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
