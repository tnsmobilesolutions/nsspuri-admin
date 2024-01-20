// ignore_for_file: public_member_api_docs, must_be_immutable

//import 'package:pdf/widgets.dart' as pdfLib;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import 'package:sdp/constant/back_arrow_icon.dart';

class PrintingDocsPage extends StatefulWidget {
  final pw.Document doc;
  // void Function(String? selectedFormat) onFormatChange;
  PrintingDocsPage({
    Key? key,
    required this.doc,
    // required this.onFormatChange,
  }) : super(key: key);

  @override
  State<PrintingDocsPage> createState() => _PrintingDocsPageState();
}

class _PrintingDocsPageState extends State<PrintingDocsPage> {
  PdfPageFormat selectedPageFormat = PdfPageFormat.a4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Print your Invoice',
      //     style: Theme.of(context).textTheme.headlineLarge,
      //   ),
      //   centerTitle: false,
      //   leading: BackArrowButton.backArrowIcon(context, () {
      //     Navigator.pop(context);
      //   }),
      // ),
      body: Center(
        child: PdfPreview(
          dpi: 300,
          canChangeOrientation: true,
          canDebug: true,
          canChangePageFormat: true,
          build: (format) => widget.doc.save(),
          pageFormats: {
            'A4': PdfPageFormat.a4.copyWith(
              marginLeft: 10.0,
              marginRight: 10.0,
              marginTop: 10.0,
              marginBottom: 10.0,
              height: 1000,
            ),
            'A5': PdfPageFormat.a5.copyWith(
              marginLeft: 20.0,
              marginRight: 20.0,
              marginTop: 20.0,
              marginBottom: 20.0,
              height: 500,
            ),

            // Add more page formats as needed
          },
          allowPrinting: true,
          allowSharing: true,

          onPageFormatChanged: (value) {
            if (value.toString().contains("A5")) {
              setState(() {
                selectedPageFormat = PdfPageFormat.a5;
              });
              // widget.onFormatChange("A5");
            } else {
              setState(() {
                selectedPageFormat = PdfPageFormat.a4;
              });
              //widget.onFormatChange("A4");
              // print("page format: $selectedPageFormat");
            }
          },

          // initialPageFormat: PdfPageFormat.a4.copyWith(
          //   marginLeft: 10.0,
          //   marginRight: 10.0,
          //   marginTop: 10.0,
          //   marginBottom: 10.0,
          // ),
          pdfFileName: 'invoice.pdf',
        ),
      ),
    );
    // PdfPreview(
    //   build: (format) => printInvoice(),
    // ),
  }
}
