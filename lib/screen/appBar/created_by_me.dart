// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/utilities/network_helper.dart';

class CreatedByMe extends StatefulWidget {
  const CreatedByMe({super.key});

  @override
  State<CreatedByMe> createState() => _CreatedByMeState();
}

class _CreatedByMeState extends State<CreatedByMe> {
  List<DevoteeModel> allDevoteesCreatedByMe = [];

  Future<void> fetchDelegatesByMe() async {
    var currentUser = NetworkHelper().currentDevotee;
    var allDevotees = await GetDevoteeAPI()
        .devoteeListBycreatedById(currentUser?.createdById.toString() ?? "");
    if (allDevotees != null) {
      print("all devotee by me length: ${allDevotees["data"].length}");
      setState(() {
        for (int i = 0; i < allDevotees["data"].length; i++) {
          allDevoteesCreatedByMe.add(allDevotees["data"][i]);
        }
      });
    } else {
      print("No delegates by me !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            await fetchDelegatesByMe();
            if (context.mounted) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DevoteeListPage(
                    pageFrom: "Dashboard",
                    status: "allDevotee",
                    devoteeList: allDevoteesCreatedByMe,
                  );
                },
              ));
            }
          },
          child: const Text(
            'Created By Me',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
