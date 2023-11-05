// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MultipleEditPali extends StatefulWidget {
  MultipleEditPali({Key? key, required this.docIds}) : super(key: key);
  List<String> docIds;

  @override
  State<MultipleEditPali> createState() => _MultipleEditPaliState();
}

class _MultipleEditPaliState extends State<MultipleEditPali> {
  TextEditingController editPaliDatecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            //   // color: Colors.white,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      width: 250,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: editPaliDatecontroller,
                keyboardType: TextInputType.number,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse('2024-02-01'),
                      firstDate: DateTime(1947),
                      lastDate: DateTime(2050));
                  if (selectedDate != null) {
                    setState(() {
                      editPaliDatecontroller.text =
                          DateFormat('dd-MMM-yyyy').format(selectedDate);
                    });
                  } else {
                    editPaliDatecontroller.text = '';
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Change Pali Date',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
