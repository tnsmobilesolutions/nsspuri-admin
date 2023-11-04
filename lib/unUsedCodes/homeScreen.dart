// ignore_for_file: file_names
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sdp/API/paliaaAPI.dart';
// import 'package:sdp/API/userAPI.dart';
// import 'package:sdp/Login/EmailSignIn.dart';
// import 'package:sdp/Models/sammilaniModel.dart';
// import 'package:sdp/Models/vaktaModel.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:sdp/unUsedCodes/add_edit_dilougeBox.dart';
// import 'package:sdp/screen/appBar/actionWidget.dart';
// import 'package:sdp/screen/appBar/leadingImage.dart';
// import 'package:sdp/unUsedCodes/newSearch.dart';
// import 'package:sdp/unUsedCodes/print.dart';
// import 'package:sdp/screen/appBar/search.dart';

// import 'package:sdp/unUsedCodes/table_header.dart';
// import 'package:sdp/utility.dart';
// import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
// import 'package:uuid/uuid.dart';

// // typedef OnSearchPress = void Function(List<VaktaModel>?);

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isChecked = false;
//   // List<VaktaModel>? searchItem;
//   VaktaModel? editedVaktadata;
//   List<VaktaModel>? searchItem;
//   // List<VaktaModel> devotedetails = [];
//   int searchDasboardIndexNumber = 0;
//   int printDashboardIndexNumber = 0;
//   int printSearchIndexNumber = 0;
//   bool showButtons = false;
//   String? selectedtypesearch;
//   String? sdpseacrchfield;
//   var baloobhaina2font;
//   var notoSansfont;

//   // fetchDetails() async {
//   //   final dddevotedetails = await PaliaAPI().fetchAllPalias();
//   //   setState(() {
//   //     devotedetails = dddevotedetails;
//   //   });
//   // }

//   final _formKey = GlobalKey<FormState>();
//   final PaliaNameController = TextEditingController();
//   final paliDateController = TextEditingController();
//   final receiptDateController = TextEditingController();
//   final sanghaNameController = TextEditingController();
//   final sammilaniPlaceController = TextEditingController();
//   final pranamiController = TextEditingController();
//   final sammilaniYearController = TextEditingController();
//   final remarkController = TextEditingController();
//   final sammilaniNumberController = TextEditingController();
//   final receiptNumberController = TextEditingController();
//   final searchSanghaController = TextEditingController();
//   // Search

//   // String? currentAppMode;

//   // APIType? type;
//   bool isSelected = false;

//   VaktaModel? selectedUser;

//   showViewDialouge(VaktaModel item) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Palia Detils',
//                     style: TextStyle(
//                       color: Color(0XFF3f51b5),
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         searchDasboardIndexNumber = 0;
//                         // dashboardindexNumber = 0;
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.close, color: Color(0XFF3f51b5)))
//                 ],
//               ),
//               content: ViewPalia(item: item));
//         });
//   }

//   showdilouge(
//     String title,
//     String buttonText,
//   ) {
//     showDialog(
//       context: context,
//       // barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color(0XFF3f51b5),
//                 ),
//               ),
//               IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.close))
//             ],
//           ),
//           content: SingleChildScrollView(
//               child: Add_Edit_Dialougebox(
//             receiptDateController: receiptDateController,
//             receiptNumberController: receiptNumberController,
//             PaliaNameController: PaliaNameController,
//             formKey: _formKey,
//             paliDateController: paliDateController,
//             pranamiController: pranamiController,
//             remarkController: remarkController,
//             sammilaniNumberController: sammilaniNumberController,
//             sammilaniYearController: sammilaniYearController,
//             sanghaNameController: sanghaNameController,
//             sammilaniPlaceController: sammilaniPlaceController,
//           )),
//           actions: <Widget>[
//             Center(
//               child: CupertinoButton(
//                 color: const Color(0XFF3f51b5),
//                 child: Text(buttonText),
//                 onPressed: () async {
//                   final currentUserData = await UserAPI().getCurrentUserData();

//                   String formattedDate =
//                       DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());
//                   // DateFormat('yyyy-MM-dd – kk:mm').format(now);

//                   if (_formKey.currentState != null) {
//                     if (_formKey.currentState!.validate()) {
//                       if (buttonText == 'Add') {
//                         VaktaModel addUser = VaktaModel(
//                           sammilaniData: SammilaniModel(
//                               sammilaniNumber:
//                                   sammilaniNumberController.text.trim(),
//                               sammilaniYear:
//                                   sammilaniYearController.text.trim(),
//                               sammilaniPlace:
//                                   sammilaniPlaceController.text.trim()),
//                           name: PaliaNameController.text.trim(),
//                           createdBy: currentUserData?.name,
//                           createdOn: formattedDate.toString(),
//                           // formatted.toString(),
//                           docId: const Uuid().v1(),
//                           pranaami: double.parse(
//                               pranamiController.text.trim() == ''
//                                   ? '0.0'
//                                   : pranamiController.text.trim()),
//                           remark: remarkController.text.trim(),
//                           sangha: sanghaNameController.text.trim(),
//                           paaliDate: paliDateController.text,
//                           receiptDate: receiptDateController.text,
//                           receiptNo: receiptNumberController.text,
//                         );
//                         await PaliaAPI().addUser(addUser);
//                         Navigator.popUntil(context, (route) => route.isFirst);
//                         Navigator.push(context, MaterialPageRoute(
//                           builder: (context) {
//                             return const HomeScreen();
//                           },
//                         ));
//                       }
//                       if (buttonText == 'Update') {
//                         VaktaModel editUser = VaktaModel(
//                           name: PaliaNameController.text.trim(),
//                           updatedBy: currentUserData?.name,
//                           updatedOn: formattedDate.toString(),
//                           pranaami: double.parse(
//                               pranamiController.text.trim() == ''
//                                   ? '0.0'
//                                   : pranamiController.text.trim()),
//                           remark: remarkController.text.trim(),
//                           sammilaniData: SammilaniModel(
//                             sammilaniNumber:
//                                 sammilaniNumberController.text.trim(),
//                             sammilaniYear: sammilaniYearController.text.trim(),
//                             sammilaniPlace:
//                                 sammilaniPlaceController.text.trim(),
//                           ),
//                           sangha: sanghaNameController.text.trim(),
//                           paaliDate: paliDateController.text,
//                           docId: editedVaktadata?.docId,
//                           createdBy: editedVaktadata?.createdBy,
//                           createdOn: editedVaktadata?.createdOn,
//                           receiptDate: receiptDateController.text,
//                           receiptNo: receiptNumberController.text,
//                           //
//                         );
//                         showDialog<String>(
//                           context: context,
//                           builder: (BuildContext context) => AlertDialog(
//                             title: const Text('Edit Palia Details'),
//                             content: const Text(
//                                 'Do You Want to Update Palia Details'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () =>
//                                     Navigator.pop(context, 'Cancel'),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () async {
//                                   await PaliaAPI().editPaliaDetails(editUser);

//                                   Navigator.popUntil(
//                                       context, (route) => route.isFirst);

//                                   Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) {
//                                       return const HomeScreen();
//                                     },
//                                   ));
//                                 },
//                                 child: const Text('Update'),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     }
//                   }
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();

//     // fetchDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int dashboardindexNumber = 0;
//     //DashboardList
//     List<TableRow> PaliasTableRows(List<VaktaModel> devotedetails) {
//       List<TableRow> PaliasTableRows = devotedetails.map<TableRow>((item) {
//         dashboardindexNumber = dashboardindexNumber + 1;
//         // List<Map<String, dynamic>> _data = List.generate(200, ((index) => {}));
//         return TableHelper().getTableRowData(item, dashboardindexNumber,

//             //View
//             () {
//           showViewDialouge(item);
//         },
//             //Edit
//             (() {
//           // dashboardindexNumber = 0;
//           setState(() {
//             editedVaktadata = item;
//             PaliaNameController.text = item.name ?? '';
//             sanghaNameController.text = item.sangha ?? '';
//             pranamiController.text = item.pranaami.toString();
//             paliDateController.text = item.paaliDate ?? '';
//             sammilaniNumberController.text =
//                 item.sammilaniData?.sammilaniNumber ?? '';
//             sammilaniYearController.text =
//                 item.sammilaniData?.sammilaniYear ?? '';
//             sammilaniPlaceController.text =
//                 item.sammilaniData?.sammilaniPlace ?? '';
//             remarkController.text = item.remark ?? '';
//             receiptDateController.text = item.receiptDate ?? '';
//             receiptNumberController.text = item.receiptNo ?? '';
//           });
//           showdilouge('Update Palia Details', 'Update');
//         }),
//             //delete
//             (() {
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => AlertDialog(
//               title: const Text('Delete User'),
//               content:
//                   const Text('Do You Want to delete the user permanently?'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => Navigator.pop(context, 'Cancel'),
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // dashboardindexNumber = 0;
//                     PaliaAPI().removePalia(item.docId);
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return const HomeScreen();
//                       },
//                     ));
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//           );
//         }),
// // Check
// // View
//             ((value) {
//           setState(() {
//             isChecked = !isChecked;
//           });
//         }),
//             // ckeckbox value
//             isChecked,
//             showButtons);
//       }).toList();

//       PaliasTableRows.insert(
//           0,
//           TableHelper().getTableHeader(showButtons, (value) {
//           
//           }));
//       return PaliasTableRows;
//     }

//     //printDashboardTable
//     List<pw.TableRow> PaliasprintTableRows(
//         List<VaktaModel> devotedetails, font) {
//       List<pw.TableRow> PaliasPrintTableRows =
//           devotedetails.map<pw.TableRow>((item) {
//         printDashboardIndexNumber = printDashboardIndexNumber + 1;
//         // List<Map<String, dynamic>> _data = List.generate(200, ((index) => {}));
//         return PrintTableHelper().getPrintTableRowData(
//           item,
//           printDashboardIndexNumber,
//         );
//       }).toList();

//       PaliasPrintTableRows.insert(0, PrintTableHelper().getPrintTableHeader());
//       return PaliasPrintTableRows;
//     }

//     //printSearchTable
//     List<pw.TableRow> PrintablesearchRow = searchItem != null
//         ? searchItem!.map<pw.TableRow>(
//             (item) {
//               printSearchIndexNumber = printSearchIndexNumber + 1;
//               return PrintTableHelper().getPrintTableRowData(
//                 item,
//                 printSearchIndexNumber,
//               );
//             },
//           ).toList()
//         : [];
//     PrintablesearchRow.insert(0, PrintTableHelper().getPrintTableHeader());

// //SearchItem
//     List<TableRow> searchRow = searchItem != null
//         ? searchItem!.map<TableRow>(
//             (item) {
//               searchDasboardIndexNumber = searchDasboardIndexNumber + 1;
//               return TableHelper()
//                   .getTableRowData(item, searchDasboardIndexNumber,
//                       //view
//                       () {
//                 searchDasboardIndexNumber = 0;

//                 showViewDialouge(item);
//               },
//                       //Edit
//                       (() {
//                 searchDasboardIndexNumber = 0;
//                 setState(() {
//                   editedVaktadata = item;
//                   PaliaNameController.text = item.name ?? '';
//                   sanghaNameController.text = item.sangha ?? '';
//                   pranamiController.text =
//                       Utility.formatCurrency(item.pranaami);
//                   paliDateController.text = item.paaliDate ?? '';
//                   sammilaniNumberController.text =
//                       item.sammilaniData?.sammilaniNumber ?? '';
//                   sammilaniYearController.text =
//                       item.sammilaniData?.sammilaniYear ?? '';
//                   sammilaniPlaceController.text =
//                       item.sammilaniData?.sammilaniPlace ?? '';
//                   remarkController.text = item.remark ?? '';
//                   receiptDateController.text = item.receiptDate ?? '';
//                   receiptNumberController.text = item.receiptNo ?? '';
//                 });
//                 showdilouge('Update Palia Details', 'Update');
//               }),
//                       //delete
//                       (() {
//                 showDialog<String>(
//                   context: context,
//                   builder: (BuildContext context) => AlertDialog(
//                     title: const Text('Delete User'),
//                     content: const Text(
//                         'Do You Want to delete the user permanently?'),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () => Navigator.pop(context, 'Cancel'),
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           searchDasboardIndexNumber = 0;
//                           PaliaAPI().removePalia(item.docId);
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return const HomeScreen();
//                             },
//                           ));
//                           Navigator.pop(context);
//                         },
//                         child: const Text('OK'),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//                       // Checked / Unchecked
//                       ((value) {
//                 setState(() {
//                   isChecked = !isChecked;
//                 });
//               }),
//                       // ckeckbox value
//                       isChecked,
//                       showButtons);
//             },
//           ).toList()
//         : [];
//     searchRow.insert(
//         0,
//         TableHelper().getTableHeader(showButtons, (value) {
//         
//         }));
//     return Scaffold(
//       appBar: AppBar(
//         leading: const LeadingImage(),
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'ସମ୍ମିଳନୀ ଦିନିକିଆ ପାଳି',
//         ),
//         actions: const [ActionWidget()],
//       ),
//       body: searchItem == null
//           ? SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: FutureBuilder(
//                           future: PaliaAPI().fetchAllPalias(),
//                           builder:
//                               (BuildContext context, AsyncSnapshot snapshot) {
//                             if (snapshot.hasError) {
//                               return const Text('SNAPSHOT ERROR');
//                             }

//                             if (snapshot.connectionState ==
//                                 ConnectionState.done) {
//                               return Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () {
//                                             // dashboardindexNumber = 0;
//                                             searchDasboardIndexNumber = 0;
//                                             printDashboardIndexNumber = 0;
//                                             printSearchIndexNumber = 0;
//                                             setState(() {
//                                               showButtons = !showButtons;
//                                             });
//                                           },
//                                           icon: const Icon(
//                                             Icons.settings,
//                                             color: Color(0XFF3f51b5),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 20),
//                                         IconButton(
//                                           onPressed: () async {
//                                             printDashboardIndexNumber = 0;
//                                             printSearchIndexNumber = 0;
//                                             final doc = pw.Document();
//                                             baloobhaina2font =
//                                                 await PdfGoogleFonts
//                                                     .balooBhaina2Regular();
//                                             notoSansfont = await PdfGoogleFonts
//                                                 .notoSansOriyaRegular();
//                                             doc.addPage(
//                                               pw.Page(
//                                                 orientation:
//                                                     pw.PageOrientation.portrait,
//                                                 pageFormat: PdfPageFormat.a4,
//                                                 build: (pw.Context context) {
//                                                   // return pw.Text('Hello');
//                                                   return pw.Column(children: [
//                                                     pw.Row(
//                                                         mainAxisAlignment: pw
//                                                             .MainAxisAlignment
//                                                             .center,
//                                                         children: [
//                                                           pw.Text('ଜୟଗୁରୁ',
//                                                               style:
//                                                                   pw.TextStyle(
//                                                                 font:
//                                                                     baloobhaina2font,
//                                                                 fontSize: 20,
//                                                                 fontWeight: pw
//                                                                     .FontWeight
//                                                                     .normal,
//                                                               ))
//                                                         ]),
//                                                     pw.SizedBox(
//                                                       height: 30,
//                                                     ),
//                                                     pw.Table(
//                                                       border:
//                                                           const pw.TableBorder(
//                                                         horizontalInside:
//                                                             pw.BorderSide(
//                                                                 width: 0.3,
                                                                // color: Color(0XFF3f51b5),
//                                                                 style: pw
//                                                                     .BorderStyle
//                                                                     .solid),
//                                                       ),
//                                                       children:
//                                                           PaliasprintTableRows(
//                                                               snapshot.data,
//                                                               baloobhaina2font),
//                                                     ),
//                                                   ]);
//                                                 },
//                                               ),
//                                             );

//                                             PdfPreview(
//                                               build: (format) => doc.save(),
//                                             );
//                                             await Printing.layoutPdf(
//                                                 onLayout: (PdfPageFormat
//                                                         format) async =>
//                                                     doc.save());
//                                           },
//                                           icon: const Icon(
//                                             Icons.print,
//                                             color: Color(0XFF3f51b5),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Card(
//                                       elevation: 10,
//                                       child: Column(
//                                         children: [
//                                           Table(
//                                             columnWidths: const {
//                                               0: FlexColumnWidth(0.2),
//                                               1: FlexColumnWidth(0.4),
//                                               2: FlexColumnWidth(0.4),
//                                               3: FlexColumnWidth(0.4),
//                                               4: FlexColumnWidth(0.4),
//                                               5: FlexColumnWidth(0.4),
//                                               6: FlexColumnWidth(0.4),
//                                               7: FlexColumnWidth(0.4),
//                                             },
//                                             defaultVerticalAlignment:
//                                                 TableCellVerticalAlignment
//                                                     .middle,
//                                             border: const TableBorder(
//                                               horizontalInside: BorderSide(
//                                                   width: 0.3,
//                                                   color: Color(0XFF3f51b5),
//                                                   style: BorderStyle.solid),
//                                             ),
//                                             children:
//                                                 PaliasTableRows(snapshot.data),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }
//                             return const Center(
//                                 child: CircularProgressIndicator(
//                               color: Colors.black,
//                             ));
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(' Total Record - ${searchItem?.length}'),
//                         Text(
//                             'Search By- $selectedtypesearch on $sdpseacrchfield'),
//                         if (searchItem?.length != null)
//                           Text(
//                               'Total Pranami = ${searchItem?.length} × 1101 = ${(searchItem?.length)! * (1101)} '),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) {
//                                       return const HomeScreen();
//                                     },
//                                   ));
//                                 },
//                                 child: const Text('Reset')),
//                             IconButton(
//                               onPressed: () {
//                                 searchDasboardIndexNumber = 0;
//                                 printSearchIndexNumber = 0;
//                                 printDashboardIndexNumber = 0;

//                                 setState(() {
//                                   showButtons = !showButtons;
//                                 });
//                               },
//                               icon: const Icon(
//                                 Icons.settings,
//                                 color: Color(0XFF3f51b5),
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             IconButton(
//                               onPressed: () async {
//                                 final doc = pw.Document();
//                                 printSearchIndexNumber = 0;
//                                 printDashboardIndexNumber = 0;
//                                 // dashboardindexNumber = 0;
//                                 searchDasboardIndexNumber = 0;

//                                 doc.addPage(
//                                   pw.Page(
//                                     orientation: pw.PageOrientation.portrait,
//                                     pageFormat: PdfPageFormat.a4,
//                                     build: (pw.Context context) {
//                                       // return pw.Text('Hello');
//                                       return pw.Column(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.start,
//                                           children: [
//                                             pw.Row(
//                                                 mainAxisAlignment:
//                                                     pw.MainAxisAlignment.center,
//                                                 children: [
//                                                   pw.Text('JAYAGURU',
//                                                       style: pw.TextStyle(
//                                                           fontSize: 20,
//                                                           fontWeight: pw
//                                                               .FontWeight.bold))
//                                                 ]),
//                                             pw.SizedBox(
//                                               height: 30,
//                                             ),
//                                             pw.Text(
//                                                 'Search By- $selectedtypesearch on $sdpseacrchfield'),
//                                             pw.Row(
//                                               mainAxisAlignment: pw
//                                                   .MainAxisAlignment
//                                                   .spaceBetween,
//                                               children: [
//                                                 pw.Text(
//                                                     ' Total Record - ${searchItem?.length}'),
//                                                 if (searchItem?.length != null)
//                                                   pw.Text(
//                                                       'Total Pranami = ${searchItem?.length} × 1101 = ${(searchItem?.length)! * (1101)} '),
//                                               ],
//                                             ),
//                                             pw.Table(
//                                               border: const pw.TableBorder(
//                                                 horizontalInside: pw.BorderSide(
//                                                     width: 0.3,
//                                                     // color: Color(0XFF3f51b5),
//                                                     style:
//                                                         pw.BorderStyle.solid),
//                                               ),
//                                               children: PrintablesearchRow,
//                                             ),
//                                           ]);
//                                     },
//                                   ),
//                                 );

//                                 PdfPreview(
//                                   build: (format) => doc.save(),
//                                 );
//                                 await Printing.layoutPdf(
//                                     onLayout: (PdfPageFormat format) async =>
//                                         doc.save());
//                               },
//                               icon: const Icon(
//                                 Icons.print,
//                                 color: Color(0XFF3f51b5),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Table(
//                         border: const TableBorder(
//                           horizontalInside: BorderSide(
//                               width: 0.3,
//                               color: Color(0XFF3f51b5),
//                               style: BorderStyle.solid),
//                         ),
//                         defaultVerticalAlignment:
//                             TableCellVerticalAlignment.middle,
//                         children: searchRow),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
