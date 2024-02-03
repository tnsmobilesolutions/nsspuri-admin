// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/model/update_timing_model.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

class UpdateTime extends StatefulWidget {
  const UpdateTime({Key? key}) : super(key: key);

  @override
  _UpdateTimeState createState() => _UpdateTimeState();
}

class _UpdateTimeState extends State<UpdateTime> {
  final balyaStartTime = TextEditingController();
  final balyaEndTime = TextEditingController();
  final madhyanStartTime = TextEditingController();
  final madhyanEndTime = TextEditingController();
  final ratraStartTime = TextEditingController();
  final ratraEndTime = TextEditingController();
  final prasadcount1st = TextEditingController();
  final prasadcount2nd = TextEditingController();
  final prasadcount3rd = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? responseData;
  void initState() {
    super.initState();
    timingData();
    // if (responseData != null) showTiming();
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      String formattedTime = DateFormat('hh:mm a').format(
        DateTime(2022, 1, 1, selectedTime.hour, selectedTime.minute),
      );

      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  timingData() async {
    try {
      // Call the first API
      Map<String, dynamic>? timingResponse =
          await GetDevoteeAPI().updateTiming();
      responseData = timingResponse["data"];
      showTiming();

      // Call the second API
    } catch (error) {
      // Handle errors
      print("Error fetching data: $error");
    }
  }

  showTiming() {
    if (responseData != null) {
      setState(() {
        balyaStartTime.text = responseData?["balyaStartTime"] ?? "";
        balyaEndTime.text = responseData?["balyaEndTime"] ?? "";
        madhyanStartTime.text = responseData?["madhyanaStartTime"] ?? "";
        madhyanEndTime.text = responseData?["madhyanaEndTime"] ?? "";
        ratraStartTime.text = responseData?["ratraStartTime"] ?? "";
        ratraEndTime.text = responseData?["ratraEndTime"] ?? "";
      });
      print("balya : ${balyaStartTime.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            //color: Colors.white,
          ),
          height: 435,
          width: 400,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: balyaStartTime,
                    onTap: () {
                      _selectTime(context, balyaStartTime);
                    },
                    validator: (value) {
                      RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

                      if (value?.isEmpty == true) {
                        return "Please enter a time!";
                      }

                      if (!timeRegex.hasMatch(value.toString())) {
                        return "Please enter a valid time (HH:mm)!";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Balya Start Time",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: balyaEndTime,
                    onSaved: (newValue) => balyaEndTime,
                    onTap: () {
                      _selectTime(context, balyaEndTime);
                    },
                    validator: (value) {
                      RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

                      if (value?.isEmpty == true) {
                        return "Please enter a time!";
                      }

                      if (!timeRegex.hasMatch(value.toString())) {
                        return "Please enter a valid time (HH:mm)!";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Balya End Time",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: madhyanStartTime,
                    onSaved: (newValue) => madhyanStartTime,
                    onTap: () {
                      _selectTime(context, madhyanStartTime);
                    },
                    validator: (value) {
                      RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

                      if (value?.isEmpty == true) {
                        return "Please enter a time!";
                      }

                      if (!timeRegex.hasMatch(value.toString())) {
                        return "Please enter a valid time (HH:mm)!";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Madhyan Start Time",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: madhyanEndTime,
                    onSaved: (newValue) => madhyanEndTime,
                    onTap: () {
                      _selectTime(context, madhyanEndTime);
                    },
                    validator: (value) {
                      RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

                      if (value?.isEmpty == true) {
                        return "Please enter a time!";
                      }

                      if (!timeRegex.hasMatch(value.toString())) {
                        return "Please enter a valid time (HH:mm)!";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Madhyan End Time",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: ratraStartTime,
                    onSaved: (newValue) => ratraStartTime,
                    onTap: () {
                      _selectTime(context, ratraStartTime);
                    },
                    validator: (value) {
                      RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

                      if (value?.isEmpty == true) {
                        return "Please enter a time!";
                      }

                      if (!timeRegex.hasMatch(value.toString())) {
                        return "Please enter a valid time (HH:mm)!";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Ratra Start Time",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: ratraEndTime,
                    onSaved: (newValue) => ratraEndTime,
                    onTap: () {
                      _selectTime(context, ratraEndTime);
                    },
                    validator: (value) {
                      RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

                      if (value?.isEmpty == true) {
                        return "Please enter a time!";
                      }

                      if (!timeRegex.hasMatch(value.toString())) {
                        return "Please enter a valid time (HH:mm)!";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Ratra End Time",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                        UpadateTimeModel updateDate = UpadateTimeModel(
                            balyaStartTime: balyaStartTime.text,
                            balyaEndTime: balyaEndTime.text,
                            madhyanaStartTime: madhyanStartTime.text,
                            madhyanaEndTime: madhyanEndTime.text,
                            ratraStartTime: ratraStartTime.text,
                            ratraEndTime: ratraEndTime.text,
                            prasadFirstDate: responseData?["prasadFirstDate"],
                            prasadSecondDate: responseData?["prasadSecondDate"],
                            prasadThirdDate: responseData?["prasadThirdDate"]);
                        print("query : $updateDate");
                        await PutDevoteeAPI().updateTiming(updateDate);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Prasad Timing updated successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardPage()),
                        );
                      },
                      child: const Text("Confirm"))
                ],
              ),
            ),
          ),
        ));
  }
}
