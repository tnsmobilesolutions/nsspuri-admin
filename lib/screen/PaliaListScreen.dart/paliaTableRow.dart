// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/API/delete_devotee.dart';
import 'package:sdp/model/devotee_model.dart';

import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';

import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

class PaliaTableRow extends StatefulWidget {
  PaliaTableRow({
    Key? key,
    required this.devoteeDetails,
    required this.slNo,
    required this.showMenu,
    this.allCheck,
  }) : super(key: key);
  DevoteeModel devoteeDetails;
  final int slNo;
  bool showMenu;
  bool? allCheck;

  @override
  State<PaliaTableRow> createState() => _PaliaTableRowState();
}

class _PaliaTableRowState extends State<PaliaTableRow> {
  // List<String> selectedPalia = [];
  bool isCheck = false;
  @override
  void initState() {
    super.initState();
    if (widget.allCheck == false) {
      widget.allCheck = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                (widget.slNo).toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: widget.devoteeDetails.profilePhotoUrl !=
                            null &&
                        widget.devoteeDetails.profilePhotoUrl!.isNotEmpty
                    ? NetworkImage(widget.devoteeDetails.profilePhotoUrl!)
                        as ImageProvider
                    : AssetImage('assets/images/profile.jpeg') as ImageProvider,
              ),
            ),
            Expanded(
              child: Text(
                widget.devoteeDetails.name != null
                    ? '${widget.devoteeDetails.name}'
                    : "-",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                widget.devoteeDetails.sangha != null
                    ? '${widget.devoteeDetails.sangha}'
                    : "-",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                widget.devoteeDetails.dob != null
                    ? '${widget.devoteeDetails.dob}'
                    : "-",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${widget.devoteeDetails.status}',
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.showMenu == true)
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.devoteeDetails.name.toString()),
                                    IconButton(
                                        color: Colors.deepOrange,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close))
                                  ],
                                ),
                                Text(widget.devoteeDetails.sangha.toString()),
                              ],
                            ),
                            content: ViewPalia(
                                devoteeDetails: widget.devoteeDetails),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info, color: Colors.deepOrange))),
            if (widget.showMenu == true)
              Expanded(
                  child: IconButton(
                      color: Colors.deepOrange,
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Edit Palia Details'),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.deepOrange,
                                        ))
                                  ],
                                ),
                                content: AddPageDilouge(
                                  devoteeId: widget.devoteeDetails.devoteeId
                                      .toString(),
                                  title: "edit",
                                ));
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.deepOrange,
                      ))),
            // if (widget.showMenu == true)
            //   Expanded(
            //       child: IconButton(
            //           color: const Color(0XFF3f51b5),
            //           onPressed: () {
            //             showDialog<String>(
            //               context: context,
            //               builder: (BuildContext context) => AlertDialog(
            //                 title: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     const Text('Delete User'),
            //                     IconButton(
            //                         color: const Color(0XFF3f51b5),
            //                         onPressed: () {
            //                           Navigator.pop(context);
            //                         },
            //                         icon: const Icon(Icons.close))
            //                   ],
            //                 ),
            //                 content: const Text(
            //                     'Do You Want to delete the user permanently?'),
            //                 actions: <Widget>[
            //                   TextButton(
            //                     onPressed: () =>
            //                         Navigator.pop(context, 'Cancel'),
            //                     child: const Text('Cancel'),
            //                   ),
            //                   TextButton(
            //                     onPressed: () async {
            //                       await DeleteDevoteeAPI().deleteSingleDevotee(
            //                           widget.devoteeDetails.devoteeId
            //                               .toString());
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                             builder: (context) => DashboardPage(),
            //                           ));
            //                     },
            //                     child: const Text('OK'),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //           icon: const Icon(
            //             Icons.delete,
            //           ),),),
          ],
        ),
        const Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
