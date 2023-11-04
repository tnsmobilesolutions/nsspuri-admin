// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:sdp/Models/vaktaModel.dart';

// class TableHelper {
//   TableRow getTableHeader(
//     bool showButtons,
//     Function(bool?)? onHeaderCheckChanged,
//   ) {
//     return TableRow(children: <Widget>[
//       Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Checkbox(
//           value: false,
//           onChanged: onHeaderCheckChanged,
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Text(
//           'କ୍ରମିକ ନଂ.',
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Text(
//           'ପାଳିଆ ନାମ',
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Text(
//           'ସଂଘ',
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Text(
//           'ପାଳି ତାରିଖ',
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Text(
//           'ପ୍ରଣାମି',
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//       if (showButtons == true)
//         const Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Text(
//             textAlign: TextAlign.center,
//             'View',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//       if (showButtons == true)
//         const Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Text(
//             textAlign: TextAlign.center,
//             'Edit',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//       if (showButtons == true)
//         const Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Text(
//             textAlign: TextAlign.center,
//             'Delete',
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ),
//     ]);
//   }

//   TableRow getTableRowData(
//     VaktaModel item,
//     int i,
//     VoidCallback onViewPressed,
//     VoidCallback editOnPressed,
//     VoidCallback deleteOnPressed,
//     Function(bool?) onCheckedBox,
//     bool? value,
//     bool? showButtons,
//   ) {
//     return TableRow(children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Checkbox(
//           key: Key(item.docId ?? "0"),
//           value: value,
//           onChanged: onCheckedBox,
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(i.toString()),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(item.name.toString()),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(item.sangha.toString()),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(item.paaliDate.toString()),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           '₹${item.pranaami}',
//         ),
//       ),
//       if (showButtons == true)
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: IconButton(
//               alignment: Alignment.center,
//               onPressed: onViewPressed,
//               icon: const Icon(
//                 Icons.visibility,
//                 color: Color(0XFF3f51b5),
//               )),
//         ),
//       if (showButtons == true)
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: IconButton(
//               alignment: Alignment.center,
//               onPressed: editOnPressed,
//               icon: const Icon(
//                 Icons.edit,
//                 color: Color(0XFF3f51b5),
//               )),
//         ),
//       if (showButtons == true)
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: IconButton(
//               alignment: Alignment.center,
//               onPressed: deleteOnPressed,
//               icon: const Icon(
//                 Icons.delete,
//                 color: Color(0XFF3f51b5),
//               )),
//         )
//     ]);
//   }
// }
