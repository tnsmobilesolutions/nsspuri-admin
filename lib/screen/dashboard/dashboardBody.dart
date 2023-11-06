// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/dashboard/dummyDashBoard.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.5),
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: GetDevoteeAPI().currentDevotee(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(17.0),
                child: InkWell(
                  highlightColor: const Color.fromARGB(255, 0, 0, 0),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PaliaListPage();
                      },
                    ));
                  },
                  child: const Card(
                    elevation: 10,
                    shadowColor: Color(0XFF3f51b5),
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const DummyDashBoard();
            }
          },
        );
      },
    );
  }
}
