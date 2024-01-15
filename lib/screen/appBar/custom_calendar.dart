// ignore_for_file: library_private_types_in_public_api, must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class CustomCalender extends StatefulWidget {
  CustomCalender({
    super.key,
    this.day,
    this.month,
    this.year,
    required this.forEdit,
  });
  String? day, month, year;
  bool forEdit;

  @override
  _CustomCalenderState createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  List<String> dates = List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  List<String> years = List.generate(
      DateTime.now().year - 1879, (index) => (1880 + index).toString());

  String? selectedDate = '1';
  String? selectedMonth = 'Jan';
  String? selectedYear = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();

    if (widget.forEdit) {
      if ((widget.day?.isNotEmpty == true) &&
          (widget.month?.isNotEmpty == true) &&
          (widget.year?.isNotEmpty == true)) {
        print("day: ${widget.day == null}");
        print("month: ${widget.month}");
        print("year: ${widget.year}");
        selectedDate = widget.day.toString();
        selectedMonth = getMonthName(widget.month.toString(), months);
        selectedYear = widget.year.toString();
      } else {
        selectedDate = '1';
        selectedMonth = 'Jan';
        selectedYear = DateTime.now().year.toString();
      }
    }
  }
  // @override
  // void initState() {
  //   super.initState();

  //   if (widget.forEdit) {
  //     if ((widget.day != null || widget.day?.isNotEmpty == true) &&
  //         (widget.month != null || widget.month?.isNotEmpty == true) &&
  //         (widget.year != null || widget.year?.isNotEmpty == true)) {
  //       print("day: ${widget.day == null}");
  //       print("month: ${widget.month}");
  //       print("year: ${widget.year}");
  //       selectedDate = widget.day.toString();
  //       selectedMonth = getMonthName(widget.month.toString(), months);
  //       selectedYear = widget.year.toString();
  //     } else {
  //       selectedDate = '1';
  //       selectedMonth = 'Jan';
  //       selectedYear = DateTime.now().year.toString();
  //     }
  //   }
  // }

  String getMonthName(String monthNumber, List<String> months) {
    int index = int.parse(monthNumber) - 1;
    if (index >= 0 && index < months.length) {
      return months[index];
    } else {
      return "Invalid Month";
    }
  }

  // String getMonthName(String monthNumber, List<String> months) {
  //   try {
  //     int index = int.parse(monthNumber) - 1;
  //     if (index >= 0 && index < months.length) {
  //       return months[index];
  //     } else {
  //       return "Invalid Month";
  //     }
  //   } catch (e) {
  //     return "Invalid Month";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                menuMaxHeight: 300,
                iconEnabledColor: Colors.deepOrange,
                value: selectedDate,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDate = newValue!;
                  });
                },
                items: dates.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                menuMaxHeight: 300,
                iconEnabledColor: Colors.deepOrange,
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                menuMaxHeight: 300,
                iconEnabledColor: Colors.deepOrange,
                value: selectedYear,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
                items: years.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fixedSize: const Size(100, 40),
            ),
            onPressed: () {
              print("$selectedDate-$selectedMonth-$selectedYear");
              Navigator.of(context)
                  .pop('$selectedDate-$selectedMonth-$selectedYear');
            },
            child: Text(
              "Submit",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.merge(const TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
