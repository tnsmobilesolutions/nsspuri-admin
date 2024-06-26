import 'package:flutter/material.dart';
import 'package:sdp/API/events.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/event_model.dart';
import 'package:sdp/responsive.dart';

import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AttendeeListPage extends StatefulWidget {
  AttendeeListPage(
      {Key? key, required this.dataToShow, this.searchBy, this.searchKeyword
      // required this.event, required this.devotee
      })
      : super(key: key);
  String dataToShow;
  String? searchBy;
  String? searchKeyword;

  @override
  State<AttendeeListPage> createState() => _AttendeeListPageState();
}

class _AttendeeListPageState extends State<AttendeeListPage>
    with TickerProviderStateMixin {
  bool editpaliDate = false;
  bool isAscending = false;
  bool showMenu = false;
  bool isLoading = true;

  int totalPages = 0, dataCount = 0, currentPage = 1;
  int dataCountPerPage = RemoteConfigHelper().getDataCountPerPage;
  String getSLno(int index) {
    List<int> slList = List.generate(
      dataCountPerPage,
      (index) => (currentPage - 1) * dataCountPerPage + index + 1,
    );
    if (index < slList.length) {
      return slList[index].toString();
    } else {
      return ''; // or handle the out-of-range case appropriately
    }
  }

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
      future: widget.dataToShow == 'allData'
          ? EventsAPI().getAllEvent('1')
          : EventsAPI().searchAttendees(
              eventId: '1',
              searchBy: widget.searchBy,
              searchKeyword: widget.searchKeyword),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final allEvents = snapshot.data?['data']["data"];
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
                // print('event data ------$eventData');
                return DataRow(cells: [
                  DataCell(Text(getSLno(index))), // Display serial number
                  DataCell(SizedBox(
                    height: 50,
                    width: 50,
                    child: eventData.devotee?.profilePhotoUrl != null &&
                            eventData.devotee?.profilePhotoUrl!.isNotEmpty ==
                                true
                        ? Image.network(
                            eventData.devotee?.profilePhotoUrl ?? '',
                            height: 80,
                            width: 80,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return const Icon(Icons.error);
                            },
                          )
                        : const Image(
                            image: AssetImage('assets/images/profile.jpeg')),
                  )),
                  DataCell(Text('${eventData.devotee?.name}')),
                  DataCell(Text('${eventData.eventId}')),
                  DataCell(Text('${eventData.devoteeCode}')),
                  DataCell(Text('${eventData.devotee?.sangha}')),
                  DataCell(ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex:
                        eventData.eventAttendance == true ? 0 : 1,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.white,
                    inactiveFgColor: Colors.grey,
                    borderColor: const [Colors.grey],
                    borderWidth: 1,
                    totalSwitches: 2,
                    labels: const ['Yes', 'No'],
                    activeBgColors: const [
                      [Colors.blue],
                      [Colors.blue]
                    ],
                    onToggle: (indexx) async {
                      if (indexx == 0) {
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
                        print('true');
                        await EventsAPI().addEvent(eventReqData);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AttendeeListPage(dataToShow: 'allData');
                          },
                        ));
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
                        print('false');
                        await EventsAPI().addEvent(eventReqData);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AttendeeListPage(dataToShow: 'allData');
                          },
                        ));
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
