// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdp/constant/pagination_value.dart';

class PaginationRow extends StatelessWidget {
  final int dataCount;
  final int currentPage;
  final int totalPages;
  final Function(int page) fetchAllDevotee;
  final Function(String? page) onFieldSubmitted;

  PaginationRow({
    super.key,
    required this.dataCount,
    required this.currentPage,
    required this.totalPages,
    required this.fetchAllDevotee,
    required this.onFieldSubmitted,
  });
  TextEditingController pageController = TextEditingController();
  InputDecoration fieldDecoration(BuildContext context) {
    return const InputDecoration(
      filled: true,
      fillColor: Color.fromARGB(255, 238, 240, 250),
      hintText: "Page no.",
      hintStyle: TextStyle(fontSize: 13),
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        dataCount == 0
            ? const Text('No records found')
            : Row(
                children: [
                  Text(
                    dataCount < 10
                        ? "$dataCount"
                        : '${dataLimit * currentPage}',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('of'),
                  const SizedBox(width: 5),
                  Text(
                    '$dataCount',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('devotees'),
                ],
              ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: currentPage == 1
              ? null
              : () async {
                  fetchAllDevotee(currentPage - 1);
                },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: currentPage == 1 ? Colors.grey : Colors.deepOrange,
          ),
        ),
        Text("$currentPage of $totalPages"),
        IconButton(
          onPressed: currentPage == totalPages
              ? null
              : () async {
                  fetchAllDevotee(currentPage + 1);
                },
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: currentPage == totalPages ? Colors.grey : Colors.deepOrange,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            //height: 50,
            width: 100,
            child: TextFormField(
              controller: pageController,
              decoration: fieldDecoration(context),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                MaxValueFormatter(totalPages),
              ],
              onFieldSubmitted: onFieldSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}

class MaxValueFormatter extends TextInputFormatter {
  final int maxValue;

  MaxValueFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      final enteredValue = int.tryParse(newValue.text) ?? 0;
      if (enteredValue > maxValue || enteredValue < 1) {
        return oldValue;
      }
    }
    return newValue;
  }
}
