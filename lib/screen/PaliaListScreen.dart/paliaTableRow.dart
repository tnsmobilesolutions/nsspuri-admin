// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/utilities/network_helper.dart';

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
                child: SizedBox(
              height: 50,
              width: 50,
              child: widget.devoteeDetails.profilePhotoUrl != null &&
                      widget.devoteeDetails.profilePhotoUrl!.isNotEmpty
                  ? Image.network(
                      widget.devoteeDetails.profilePhotoUrl ?? '',
                      width: 50,
                      height: 50,
                    )
                  : const Image(
                      image: AssetImage('assets/images/profile.jpeg')),
            )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.devoteeDetails.name != null
                              ? '${widget.devoteeDetails.name}\n'
                              : "-\n",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: widget.devoteeDetails.devoteeCode.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.devoteeDetails.status}',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  widget.devoteeDetails.paidAmount != null
                      ? Text(
                          '₹ ${widget.devoteeDetails.paidAmount}',
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox(),
                ],
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
                      onPressed:
                          Networkhelper().currentDevotee?.role == "Approver" &&
                                  widget.devoteeDetails.status == "paid"
                              ? null
                              : () {
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
                                            devoteeId: widget
                                                .devoteeDetails.devoteeId
                                                .toString(),
                                            title: "edit",
                                          ));
                                    },
                                  );
                                },
                      icon: Icon(
                        Icons.edit,
                        color: Networkhelper().currentDevotee?.role ==
                                    "Approver" &&
                                widget.devoteeDetails.status == "paid"
                            ? const Color.fromARGB(255, 206, 206, 206)
                            : Colors.deepOrange,
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
