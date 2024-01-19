import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:sdp/constant/printdelegatecard.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:pdf/widgets.dart' as pw;

class DisplayPdf {
  static void delegatePDF(
      List<DevoteeModel> saledata, BuildContext context) async {
    pw.Text customText(String text) {
      return pw.Text(
        text,
        style: const pw.TextStyle(
          fontSize: 8,
          //color: pdfColor,
        ),
      );
    }

    pw.Text customText1(String text) {
      return pw.Text(
        text,
        style: const pw.TextStyle(
          fontSize: 5,
          //fontWeight: pw.FontWeight.bold,
        ),
      );
    }

    pw.Widget buildCard(String cardData) {
      return pw.Container(
        margin: const pw.EdgeInsets.all(8),
        padding: const pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        child: pw.Text(cardData),
      );
    }

    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        // pageFormat: PdfPageFormat.a4,
        //orientation: pw.PageOrientation.landscape,
        build: (context) {
          return pw.Expanded(
              child: pw.Container(
                  height: 1000,
                  // width: 800,
                  decoration:
                      pw.BoxDecoration(border: pw.Border.all(width: 0.2)),
                  child: pw.GridView(
                    crossAxisCount: 2,
                    children: [
                      buildCard('Card 1 Data'),
                      buildCard('Card 2 Data'),
                      buildCard('Card 3 Data'),
                      buildCard('Card 4 Data'),
                    ],
                  )));
        },
      ),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PrintingDocsPage(doc: doc);
    }));
  }
}
