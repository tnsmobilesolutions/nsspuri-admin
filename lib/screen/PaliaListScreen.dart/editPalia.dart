// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Models/sammilaniModel.dart';
import 'package:sdp/Models/userDetailsModel.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/sammilani_list.dart';
import 'package:sdp/sanghalist.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';

class EditPaliadilougePage extends StatefulWidget {
  EditPaliadilougePage({Key? key, required this.paliaDetails})
      : super(key: key);
  VaktaModel paliaDetails;

  @override
  State<EditPaliadilougePage> createState() => _EditPaliadilougePageState();
}

class _EditPaliadilougePageState extends State<EditPaliadilougePage> {
  final _formKey = GlobalKey<FormState>();
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
  UserDetailsModel? currentPalia;
  String formattedDate =
      DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());

  currentUser() async {
    final currentUser = await UserAPI().getCurrentUserData();
    setState(() {
      currentPalia = currentUser;
    });
  }

  @override
  void initState() {
    currentUser();
    super.initState();
    paliaNameController.text = widget.paliaDetails.name ?? '';
    sanghaNameController.text = widget.paliaDetails.sangha ?? '';
    paliDateController.text = widget.paliaDetails.paaliDate ?? '';
    receiptDateController.text = widget.paliaDetails.receiptDate ?? '';
    sammilaniPlaceController.text =
        widget.paliaDetails.sammilaniData?.sammilaniPlace ?? '';
    sammilaniNumberController.text =
        widget.paliaDetails.sammilaniData?.sammilaniNumber ?? '';
    sammilaniYearController.text =
        widget.paliaDetails.sammilaniData?.sammilaniYear ?? '';
    pranamiController.text = widget.paliaDetails.pranaami.toString();
    remarkController.text = widget.paliaDetails.remark ?? '';
    receiptNumberController.text = widget.paliaDetails.receiptNo ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.white,
      ),
      height: 435,
      width: 400,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Palia Name
              TextFormField(
                controller: paliaNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),
              //Sangha Name
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: sanghaNameController,
                    decoration: const InputDecoration(
                        labelText: 'Search Sangha Names',
                        border: OutlineInputBorder()
                        // OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                        )),
                suggestionsCallback: (pattern) async {
                  final sanghaList = SanghaUtility.getAllSanghaName();
                  return sanghaList.where((element) =>
                      element!.toLowerCase().contains(pattern.toLowerCase()));

                  // return await BackendService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.toString()),
                  );
                },
                getImmediateSuggestions: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Sangha Name Found'),
                ),
                onSuggestionSelected: (String? value) {
                  sanghaNameController.text = value.toString();
                },
              ),
              const SizedBox(height: 10),
              // Pranami
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: pranamiController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pranami',
                ),
              ),
              // Pali Date
              const SizedBox(height: 10),
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: paliDateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1947),
                            lastDate: DateTime(2050));
                        if (selectedDate != null) {
                          setState(() {
                            paliDateController.text =
                                DateFormat('dd-MMM-yyyy').format(selectedDate);
                          });
                        } else {
                          paliDateController.text = '';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded)),
                  border: const OutlineInputBorder(),
                  labelText: 'Pali Date (DD-MMM-YYYY)',
                ),
              ),
              const SizedBox(height: 10),
              // receipt Date
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: receiptDateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1947),
                            lastDate: DateTime(2050));
                        if (selectedDate != null) {
                          setState(() {
                            receiptDateController.text =
                                DateFormat('dd-MMM-yyyy').format(selectedDate);
                          });
                        } else {
                          receiptDateController.text = '';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded)),
                  border: const OutlineInputBorder(),
                  labelText: 'Receipt Date (DD-MMM-YYYY)',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // receipt Number
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: receiptNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipt Number',
                ),
              ),
              const SizedBox(height: 10),
              // Sammilani Number
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: sammilaniNumberController,
                    decoration: const InputDecoration(
                        labelText: 'Add Sammilani Number',
                        border: OutlineInputBorder()
                        // OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                        )),
                suggestionsCallback: (pattern) async {
                  final sammilaniNumber =
                      SammilaniUtility.getAllSammilaniName();
                  return sammilaniNumber.where((element) =>
                      element.sammilaniNumber!.contains(pattern.toLowerCase()));

                  // return await BackendService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.sammilaniNumber.toString()),
                  );
                },
                getImmediateSuggestions: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Sammilani Number Found'),
                ),
                onSuggestionSelected: (value) {
                  sammilaniNumberController.text =
                      value.sammilaniNumber.toString();
                  sammilaniPlaceController.text =
                      value.sammilaniPlace.toString();
                  sammilaniYearController.text = value.sammilaniYear.toString();
                },
              ),
              // TextFormField(
              //   focusNode: FocusNode(
              //     descendantsAreFocusable: false,
              //   ),
              //   controller: sammilaniNumberController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Sammilani Number',
              //   ),
              // ),
              const SizedBox(height: 10),
              // Sammilani Year
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: sammilaniYearController,
                    decoration: const InputDecoration(
                        labelText: 'Add Sammilani Year',
                        border: OutlineInputBorder()
                        // OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                        )),
                suggestionsCallback: (pattern) async {
                  final sammilanimodelist =
                      SammilaniUtility.getAllSammilaniName();
                  return sammilanimodelist.where((element) =>
                      element.sammilaniYear!.contains(pattern.toLowerCase()));

                  // return await BackendService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.sammilaniYear.toString()),
                  );
                },
                getImmediateSuggestions: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Sammilani Year Found'),
                ),
                onSuggestionSelected: (value) {
                  sammilaniNumberController.text =
                      value.sammilaniNumber.toString();
                  sammilaniPlaceController.text =
                      value.sammilaniPlace.toString();
                  sammilaniYearController.text = value.sammilaniYear.toString();
                },
              ),
              // TextFormField(
              //   focusNode: FocusNode(
              //     descendantsAreFocusable: false,
              //   ),
              //   controller: sammilaniYearController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'sammilani Year',
              //   ),
              // ),

              const SizedBox(height: 10),
              // Sammilani Place
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: sammilaniPlaceController,
                    decoration: const InputDecoration(
                        labelText: 'Add Sammilani Place',
                        border: OutlineInputBorder()
                        // OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(15.0),
                        // ),
                        )),
                suggestionsCallback: (pattern) async {
                  final sammilaniNumber =
                      SammilaniUtility.getAllSammilaniName();
                  return sammilaniNumber.where((element) => element
                      .sammilaniPlace!
                      .toLowerCase()
                      .contains(pattern.toLowerCase()));

                  // return await BackendService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.sammilaniPlace.toString()),
                  );
                },
                getImmediateSuggestions: true,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Sangha Name Found'),
                ),
                onSuggestionSelected: (value) {
                  sammilaniNumberController.text =
                      value.sammilaniNumber.toString();
                  sammilaniPlaceController.text =
                      value.sammilaniPlace.toString();
                  sammilaniYearController.text = value.sammilaniYear.toString();
                },
              ),

              // TextFormField(
              //   focusNode: FocusNode(
              //     descendantsAreFocusable: false,
              //   ),
              //   controller: sammilaniPlaceController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'sammilani Place',
              //   ),
              // ),

              const SizedBox(height: 10),
              // Remark
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: remarkController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Remark',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0XFF3f51b5)),
                  ),
                  child: const Text('Save'),
                  onPressed: () async {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Edit Palia Details'),
                            IconButton(
                                color: const Color(0XFF3f51b5),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        content:
                            const Text('Do You Want to Update Palia Details'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              VaktaModel editUser = VaktaModel(
                                  name: paliaNameController.text.trim(),
                                  updatedBy: currentPalia?.name,
                                  updatedOn: formattedDate.toString(),
                                  pranaami: double.parse(
                                      pranamiController.text.trim() == ''
                                          ? '0.0'
                                          : pranamiController.text.trim()),
                                  remark: remarkController.text.trim(),
                                  sammilaniData: SammilaniModel(
                                    sammilaniNumber:
                                        sammilaniNumberController.text.trim(),
                                    sammilaniYear:
                                        sammilaniYearController.text.trim(),
                                    sammilaniPlace:
                                        sammilaniPlaceController.text.trim(),
                                  ),
                                  sangha: sanghaNameController.text.trim(),
                                  paaliDate: paliDateController.text,
                                  receiptDate: receiptDateController.text,
                                  receiptNo: receiptNumberController.text,
                                  docId: widget.paliaDetails.docId
                                  //
                                  );
                              PaliaAPI().editPaliaDetails(editUser);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PaliaListPage(
                                      year:
                                          '${widget.paliaDetails.sammilaniData?.sammilaniYear}');
                                },
                              ));
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
