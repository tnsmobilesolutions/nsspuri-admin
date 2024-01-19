import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/model/devotee_model.dart';

class DevoteeInfoTab extends StatefulWidget {
  final DevoteeModel devoteeDetails;

  const DevoteeInfoTab({Key? key, required this.devoteeDetails})
      : super(key: key);

  @override
  State<DevoteeInfoTab> createState() => _DevoteeInfoTabState();
}

class _DevoteeInfoTabState extends State<DevoteeInfoTab> {
  final nameController = TextEditingController();

  Map<String, dynamic>? devoteeData;

  bool isChecked = false;

  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  String formatDate(String inputDate) {
    if (inputDate.isNotEmpty) {
      DateTime dateTime = DateFormat('yyyy-MM-dd', 'en_US').parse(inputDate);

      int day = dateTime.day;
      String month = monthNames[dateTime.month - 1];
      int year = dateTime.year;

      String formattedDate = '$day-$month-$year';

      return formattedDate;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final devotees = widget.devoteeDetails;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // viewDetails('Sangha', widget.item.sangha.toString()),
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepOrange,
                        width: 1,
                      ),
                      shape: BoxShape
                          .rectangle, // This makes the container circular
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            widget.devoteeDetails.profilePhotoUrl.toString()),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mobile Number',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(widget.devoteeDetails.mobileNumber.toString())
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email ID',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('${widget.devoteeDetails.emailId}')
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.devoteeDetails.ageGroup != ""
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Age',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(widget.devoteeDetails.ageGroup.toString())
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date Of Birth',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(formatDate(widget.devoteeDetails.dob ?? ""))
                          ],
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Blood Group',
                        style: TextStyle(color: Colors.grey),
                      ),
                      widget.devoteeDetails.bloodGroup != null
                          ? Text('${widget.devoteeDetails.bloodGroup}')
                          : const Text("")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.devoteeDetails.gender == "Male"
                          ? 'Bhai'
                          : "Maa")
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sangha',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text('${widget.devoteeDetails.sangha}')
                    ],
                  ),
                  Column(
                    children: [
                      // Checkbox(
                      //   value: widget
                      //       .devoteeDetails.hasParichayaPatra,
                      //   onChanged:
                      //       null, // Set to null to disable user interaction
                      // ),
                      if (widget.devoteeDetails.hasParichayaPatra != null)
                        const Text('Has Parichayapatra'),
                      widget.devoteeDetails.hasParichayaPatra == true
                          ? Text("Yes")
                          : Text("No")
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Remark',
                        style: TextStyle(color: Colors.grey),
                      ),
                      widget.devoteeDetails.remarks != null
                          ? Text('${widget.devoteeDetails.remarks}')
                          : Text("N/A")
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              if (widget.devoteeDetails.createdOn != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Created By',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.devoteeDetails.createdById.toString())
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Approved By',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.devoteeDetails.approvedBy.toString())
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Updated On',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(widget.devoteeDetails.updatedOn.toString())
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
