// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:sdp/constant/printdelegatecard.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sdp/screen/viewDevotee/constants.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class DisplayPdf {
  static const PIXEL_PER_INCH = 72.0;

  static void delegatePDF(
      List<DevoteeModel> devoteeselecteddata, BuildContext context) async {
    final img1 = await rootBundle.load('assets/images/blood.png');
    final imageBytes1 = img1.buffer.asUint8List();
    pw.Image bloodImage = pw.Image(pw.MemoryImage(imageBytes1));
    final img4 = await rootBundle.load('assets/images/Group 12.png');
    final imageBytes4 = img4.buffer.asUint8List();
    pw.Image containerImage = pw.Image(pw.MemoryImage(imageBytes4));
    final img2 = await rootBundle.load('assets/images/nsslogo.png');
    final imageBytes2 = img2.buffer.asUint8List();
    pw.Image nssLogo = pw.Image(pw.MemoryImage(imageBytes2));
    final img3 = await rootBundle.load('assets/images/Subtract.png');
    final imageBytes3 = img3.buffer.asUint8List();
    pw.Image puneSammilaniLogo = pw.Image(pw.MemoryImage(imageBytes3));
//SVG image
    final String svgRaw = await rootBundle.loadString('assets/images/3.svg');
    // final String modifiedSvg =
    //     svgRaw.replaceFirst('<ellipse', '<ellipse style="fill: green;"');

    final svgImage = pw.SvgImage(svg: svgRaw);
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

    String _toPascalCase(String input) {
      if (input.isEmpty) {
        return input;
      }

      final words = input.split(' ');
      final camelCaseWords = words.map((word) {
        if (word.isEmpty) {
          return '';
        }
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      });

      return camelCaseWords.join(' ');
    }

    int seniorCitizenAgeLimit = 70;
    int teenAgeLimit = 12;
    int calculateAge(DateTime dob) {
      DateTime now = DateTime.now();
      int age = now.year - dob.year;
      if (now.month < dob.month ||
          (now.month == dob.month && now.day < dob.day)) {
        age--;
      }
      print("age: $age");
      return age;
    }

    PdfColor getColorByDevotee(DevoteeModel devotee) {
      if (devotee.isGuest == true) return PdfColors.yellow;
      if (devotee.isSpeciallyAbled == true) return PdfColors.purple;
      if (devotee.isOrganizer == true) return PdfColors.red;

      if (devotee.age != null) {
        int age = devotee.age ?? 0;
        if (age <= teenAgeLimit) return PdfColors.green;
        if (age >= seniorCitizenAgeLimit) return PdfColors.purple;
      }

      if (devotee.dob?.isNotEmpty == true && devotee.dob != null) {
        int age = calculateAge(DateTime.parse(devotee.dob.toString()));
        if (age <= teenAgeLimit) return PdfColors.green;
        if (age >= seniorCitizenAgeLimit) return PdfColors.purple;
      }

      if (devotee.gender == "Male") return PdfColors.blue;
      if (devotee.gender == "Female") return PdfColors.pink;

      return PdfColors.blue;
    }

    pw.Widget buildCard(pw.Context context, DevoteeModel cardData) {
      return pw.Container(
        height: 4.4 * PIXEL_PER_INCH,
        width: 2.7 * PIXEL_PER_INCH,
        margin: const pw.EdgeInsets.all(8),
        padding: const pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        child: containerImage,
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
                  height: 800,
                  // width: 800,
                  decoration:
                      pw.BoxDecoration(border: pw.Border.all(width: 0.2)),
                  child: pw.GridView(
                    crossAxisCount: 2,
                    children: [
                      for (int i = 0; i < devoteeselecteddata.length; i++)
                        buildCard(context, devoteeselecteddata[i]),
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
