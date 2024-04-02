// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/events.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/model/event_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

class AttendeeTableScreen extends StatefulWidget {
  AttendeeTableScreen({
    Key? key,
    // required this.event, required this.devotee
  }) : super(key: key);
// EventModel event;
//     DevoteeModel devotee;

  @override
  State<AttendeeTableScreen> createState() => _AttendeeTableScreenState();
}

class _AttendeeTableScreenState extends State<AttendeeTableScreen>
    with TickerProviderStateMixin {
  bool editpaliDate = false;
  bool isAscending = false;
  bool showMenu = false;
  bool isLoading = true;

  List<bool> selectedList = [];

  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
  //  String getSLno(int index) {
  //   List<int> slList = List.generate(
  //     dataCountPerPage,
  //     (index) => (currentPage - 1) * dataCountPerPage + index + 1,
  //   );
  //   return slList[index].toString();
  // }

  DataColumn dataColumn(BuildContext context, String header,
      [Function(int, bool)? onSort]) {
    return DataColumn(
        onSort: onSort,
        label: Flexible(
          flex: 1,
          child: Text(
            header,
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium?.merge(
                  const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
          ),
        ));
  }

  int _counter = 1;
  Widget devoteeTable(BuildContext context) {
    return FutureBuilder(
      future: EventsAPI().getAllEvent('1'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final allEvents = snapshot.data?['data'];
          print('data------${snapshot.data}');
          // Replace the following DataTable with your own data
          return DataTable(
              showBottomBorder: true,
              columnSpacing: 30,
              dataRowMaxHeight: 80,
              columns: [
                dataColumn(context, 'Sl. No'),
                dataColumn(context, 'Image'),
                dataColumn(context, 'Name'),
                dataColumn(context, 'Event ID'),
                dataColumn(context, 'Devotee Code'),
                dataColumn(context, 'Sangha'),
                dataColumn(context, 'Are you Coming to 14th Apr?'),
              ],
              rows: List<DataRow>.generate(allEvents.length, (index) {
                EventModel eventData = EventModel.fromMap(allEvents[index]);
                return DataRow(cells: [
                  DataCell(Text('$_counter')), // Display serial number
                  DataCell(Text('Image')),
                  DataCell(Text('${eventData.devotee?.name}')),
                  DataCell(Text('Event ID')),
                  DataCell(Text('Devotee Code')),
                  DataCell(Text('Sangha')),
                  DataCell(ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex:
                        eventData.eventAttendance == true ? 0 : 1,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.grey,
                    borderWidth: 1,
                    totalSwitches: 2,
                    labels: ['Yes', 'No'],
                    activeBgColors: [
                      [Colors.blue],
                      [Colors.blue]
                    ],
                    onToggle: (indexx) async {
                      if (indexx == 1) {
                        EventModel eventReqData = EventModel(
                          devoteeCode: eventData.devoteeCode,
                          devoteeId: eventData.devoteeId,
                          eventAntendeeId: Uuid().v4(),
                          inDate: '2023-04-14',
                          outDate: '2023-04-14',
                          eventId: '1',
                          eventName: 'Puri',
                          eventAttendance: true,
                        );
                        await EventsAPI().addEvent(eventReqData);

                        // Navigator.of(context).pop();
                      } else {
                        EventModel eventReqData = EventModel(
                          devoteeCode: eventData.devoteeCode,
                          devoteeId: eventData.devoteeId,
                          eventAntendeeId: Uuid().v4(),
                          inDate: '2023-04-14',
                          outDate: '2023-04-14',
                          eventId: '1',
                          eventName: 'Puri',
                          eventAttendance: false,
                        );
                        await EventsAPI().addEvent(eventReqData);

                        // Navigator.of(context).pop();
                      }
                      print('switched to: $index');
                    },
                  ))
                ]);
              }));
        }
      },
    );
    // Counter variable to generate serial numbers
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Responsive(
                    desktop: devoteeTable(context),
                    tablet: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: devoteeTable(context),
                    ),
                    mobile: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: devoteeTable(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
