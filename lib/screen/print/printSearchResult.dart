// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:printing/printing.dart';
// import 'package:sdp/API/paliaaAPI.dart';
// import 'package:sdp/Models/vaktaModel.dart';
// import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';
// import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
// import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
// import 'package:sdp/screen/searchResult/searchResultScreen.dart';

// class PrintSearchScreen extends StatefulWidget {
//   PrintSearchScreen({
//     Key? key,
//     required this.searchModel,
//   }) : super(key: key);
//   final List<VaktaModel> searchModel;

//   @override
//   State<PrintSearchScreen> createState() => _PrintSearchScreenState();
// }

// class _PrintSearchScreenState extends State<PrintSearchScreen> {
//   dynamic baloobhainaheading;
//   font() async {
//     final a = await PdfGoogleFonts.notoSansOriyaRegular();
//     setState(() {
//       baloobhainaheading = a;
//     });
//   }

//   Expanded printSearchheadingText(String text) {
//     return Expanded(
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//             fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     font();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Text(
//           'ଜୟଗୁରୁ',
//           style: TextStyle(
//             // font: _baloobhaina2font,
//             fontSize: 20,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ]),
//       Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Total Record - ${widget.searchModel.length}'),
//               Text(
//                   'Total Pranami = ${widget.searchModel.length} × 1101 = ${(widget.searchModel.length) * (1101)} ')
//             ],
//           )
//         ],
//       ),
//       Divider(),
//       Row(mainAxisAlignment: MainAxisAlignment.start, children: []),
//       SizedBox(height: 20),
//       Row(children: [
//         printSearchheadingText('କ୍ରମିକ ନଂ'),
//         printSearchheadingText('ପାଳିଆ ନାମ'),
//         printSearchheadingText('ସଂଘ'),
//         printSearchheadingText('ପାଳି ତାରିଖ'),
//       ]),
//       SizedBox(
//         height: 12,
//       ),
//       Expanded(
//         child: ListView.builder(
//           itemCount: widget.searchModel.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         (index).toString(),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         '${widget.searchModel[index].name}',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         '${widget.searchModel[index].sangha}',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         '${widget.searchModel[index].paaliDate}',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   thickness: 0.5,
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     ]);
//   }
// }
