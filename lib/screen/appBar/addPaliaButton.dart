// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';

class AddPaliaButton extends StatelessWidget {
  AddPaliaButton({super.key});
  // final _formKey = GlobalKey<FormState>();
  final paliaNameController = TextEditingController();
  final paliDateController = TextEditingController();
  final receiptDateController = TextEditingController();
  final sanghaNameController = TextEditingController();
  final sammilaniPlaceController = TextEditingController();
  final pranamiController = TextEditingController();
  final sammilaniYearController = TextEditingController();
  final remarkController = TextEditingController();
  final sammilaniNumberController = TextEditingController();
  final receiptNumberController = TextEditingController();

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
      onPressed: (() {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Palia Details'),
                  IconButton(
                      color: const Color(0XFF3f51b5),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              content: AddPageDilouge(),
            );
          },
        );
      }),
      child: const Text(
        'Add Palia',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
