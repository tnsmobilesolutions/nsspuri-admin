// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

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
              onPressed: () async {
                final a = VaktaModel(
                  paaliDate: editPaliDatecontroller.text,
                );
                if (a.paaliDate == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Plese choose a paali date you want to update!'),
                    ),
                  );
                } else if (widget.docIds.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Plese select any Palia you want to update!'),
                    ),
                  );
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Update Paali Date'),
                          IconButton(
                              color: const Color(0XFF3f51b5),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      content: const Text(
                          'Do you want to update the paali date for selected paalia?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await PaliaAPI()
                                .editPaliDateMultiple(widget.docIds, a);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardPage(),
                                ));
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
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
