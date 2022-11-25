import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final List<String> jobs = ["IT", "Marketing", "Other Jobs", "Job1", "Job2"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jobs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? Theme.of(context).primaryColor.withOpacity(0.25)
                      : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  jobs[index],
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.black38,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
