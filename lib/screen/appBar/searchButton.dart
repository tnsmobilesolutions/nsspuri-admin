import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/search.dart';

// ignore: must_be_immutable
class SearchButton extends StatelessWidget {
  SearchButton({super.key, required this.status});
  String status;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1.0,
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Search Devotee'),
                IconButton(
                    color: const Color(0XFF3f51b5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchDevotee(
                status: status,
                // dashboardindexNumber: 0,
                searchDasboardIndexNumber: 0,
              ),
            ),
          ),
        );
      },
      child: const Text('Search'),
    );
  }
}
