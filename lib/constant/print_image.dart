// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:sdp/constant/printdelegatecard.dart';

// void DisplayPdf(BuildContext context) async {
//   final pdfImage = await imageFromAssetBundle(
//     'assets/images/bhai.jpeg',
//   );
//   // final image = await imageFromAssetBundle(
//   //   'assets/images/b.jpeg',
//   // );

//   final doc = pw.Document();
//   doc.addPage(
//     pw.Page(
//       build: (context) {
//         return pw.Column(
//           mainAxisAlignment: pw.MainAxisAlignment.start,
//           children: [
//             pw.Row(
//               children: [
//                 // Each column represents a cell in the grid
//                 pw.Expanded(
//                   child: pw.Container(
//                     alignment: pw.Alignment.topRight,
//                     padding: const pw.EdgeInsets.all(10),
//                     height: 336,
//                     width: 203,
//                     child: pw.Image(pdfImage),
//                   ),
//                 ),
//                 pw.Expanded(
//                   child: pw.Container(
//                     alignment: pw.Alignment.topRight,
//                     padding: const pw.EdgeInsets.all(10),
//                     height: 336,
//                     width: 203,
//                     child: pw.Image(pdfImage),
//                   ),
//                 ),
//               ],
//             ),
//             // Add more rows and columns as needed
//             pw.Row(
//               children: [
//                 pw.Expanded(
//                   child: pw.Container(
//                     alignment: pw.Alignment.topRight,
//                     padding: const pw.EdgeInsets.all(10),
//                     height: 336,
//                     width: 203,
//                     child: pw.Image(pdfImage),
//                   ),
//                 ),
//                 pw.Expanded(
//                   child: pw.Container(
//                     alignment: pw.Alignment.topRight,
//                     padding: const pw.EdgeInsets.all(10),
//                     height: 336,
//                     width: 203,
//                     child: pw.Image(pdfImage),
//                   ),
//                 ),
//               ],
//             ),
//             pw.Row(
//               children: [
//                 pw.Expanded(
//                   child: pw.Container(
//                     alignment: pw.Alignment.topRight,
//                     padding: const pw.EdgeInsets.all(10),
//                     height: 336,
//                     width: 203,
//                     child: pw.Image(pdfImage),
//                   ),
//                 ),
//                 pw.Expanded(
//                   child: pw.Container(
//                     alignment: pw.Alignment.topRight,
//                     padding: const pw.EdgeInsets.all(10),
//                     height: 336,
//                     width: 203,
//                     child: pw.Image(pdfImage),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       },
//     ),
//   );

//   // Navigate to the PDF route
//   Navigator.push(context, MaterialPageRoute(builder: (context) {
//     return PrintingDocsPage(doc: doc);
//   }));
// }
