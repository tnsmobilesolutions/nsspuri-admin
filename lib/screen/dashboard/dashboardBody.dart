import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/dashboard_card_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetDevoteeAPI().adminDashboard(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(width: 100, child: LinearProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (snapshot.data["data"].length) ~/ 2,
                  childAspectRatio: 1.5),
              itemCount: snapshot.data["data"].length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                DashboardStatusModel dashboarddata =
                    DashboardStatusModel.fromMap(snapshot.data["data"][index]);

                return Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: InkWell(
                    highlightColor: const Color.fromARGB(255, 0, 0, 0),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return PaliaListPage(
                            status: dashboarddata.status ?? "",
                          );
                        },
                      ));
                    },
                    child: Card(
                      elevation: 10,
                      shadowColor: const Color(0XFF3f51b5),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dashboarddata.status.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dashboarddata.count.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
