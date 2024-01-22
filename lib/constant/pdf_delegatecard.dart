// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:sdp/constant/printdelegatecard.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class DisplayPdf {
  static const PIXEL_PER_INCH = 72.0;

  static void delegatePDF(
      List<DevoteeModel> devoteeselecteddata, BuildContext context) async {
    final img3 = await rootBundle.load('assets/images/del_bg_cordinator.png');
    final imageBytes3 = img3.buffer.asUint8List();
    pw.Image cardcoordinator = pw.Image(pw.MemoryImage(imageBytes3));
    final img5 = await rootBundle.load('assets/images/del_bg_cordinator.png');
    final imageBytes5 = img5.buffer.asUint8List();
    pw.Image cardguest = pw.Image(pw.MemoryImage(imageBytes5));
    final img6 = await rootBundle.load('assets/images/del_bg_old.png');
    final imageBytes6 = img3.buffer.asUint8List();
    pw.Image oldcard = pw.Image(pw.MemoryImage(imageBytes3));
    final img4 = await rootBundle.load('assets/images/delegatebg_green.png');
    final imageBytes4 = img4.buffer.asUint8List();
    pw.Image containerImage = pw.Image(pw.MemoryImage(imageBytes4));
    final image1 = await rootBundle.load('assets/images/del_bg_bhai.png');
    final imageBytes1 = image1.buffer.asUint8List();
    pw.Image bhaiColor = pw.Image(pw.MemoryImage(imageBytes1));

    final img2 = await rootBundle.load('assets/images/del_bg_maa.png');
    final imageBytes2 = img2.buffer.asUint8List();
    pw.Image maaColor = pw.Image(pw.MemoryImage(imageBytes2));
    // final img3 = await rootBundle.load('assets/images/Subtract.png');
    // final imageBytes3 = img3.buffer.asUint8List();
    // pw.Image puneSammilaniLogo = pw.Image(pw.MemoryImage(imageBytes3));
//SVG image
    // final String svgRaw = await rootBundle.loadString('assets/images/3.svg');
    // // final String modifiedSvg =
    // //     svgRaw.replaceFirst('<ellipse', '<ellipse style="fill: green;"');

    // final svgImage = pw.SvgImage(svg: svgRaw);
    pw.Text customText(String text) {
      return pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 8, color: PdfColors.white
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

    pw.Text customText2(String text) {
      return pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 7,
          fontWeight: pw.FontWeight.bold,
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

    Object getColorByDevotee(DevoteeModel devotee) {
      if (devotee.isGuest == true) return cardguest;
      if (devotee.isSpeciallyAbled == true) return oldcard;
      if (devotee.isOrganizer == true) return cardcoordinator;

      if (devotee.age != null) {
        int age = devotee.age ?? 0;
        if (age <= teenAgeLimit) return containerImage;
        if (age >= seniorCitizenAgeLimit) return oldcard;
      }

      if (devotee.dob?.isNotEmpty == true && devotee.dob != null) {
        int age = calculateAge(DateTime.parse(devotee.dob.toString()));
        if (age <= teenAgeLimit) return containerImage;
        if (age >= seniorCitizenAgeLimit) return oldcard;
      }

      if (devotee.gender == "Male") return bhaiColor;
      if (devotee.gender == "Female") return maaColor;

      return bhaiColor;
    }

    Future<Uint8List> fetchImage(String imageUrl) async {
      try {
        Response<List<int>> response = await Dio().get<List<int>>(
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        return Uint8List.fromList(response.data!);
      } catch (e) {
        // Handle error
        print("Error fetching image: $e");
        return Uint8List(0); // Return an empty Uint8List in case of error
      }
    }

    pw.Widget buildCard(pw.Context context, DevoteeModel cardData) {
      //final netImage = networkImage(cardData.profilePhotoUrl ?? '');

      return pw.Container(
        height: 4.4 * PIXEL_PER_INCH,
        width: 2.7 * PIXEL_PER_INCH,
        margin: const pw.EdgeInsets.all(8),
        padding: const pw.EdgeInsets.all(8),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black),
        ),
        child: pw.Stack(
          children: [
            // Your image as the background
            pw.Positioned.fill(
              child: cardData.gender == "Male" ? bhaiColor : containerImage,
            ),

            pw.Positioned(
              top: 155,
              left: 30,
              child: customText(
                cardData.bloodGroup ?? '',
              ),
            ),

            // pw.Positioned(
            //   top: 155,
            //   left: 30,
            //   child: pw.Container(
            //     width: 50, // Adjust the width as needed
            //     height: 50, // Adjust the height as needed
            //     child:
            //         pw.ClipOval(child: pw.Image(netImage as pw.ImageProvider)),
            //   ),
            // ),

            pw.Positioned(
              bottom: 110,
              right: 50,
              left: 50,
              child: pw.Center(
                child: customText2(
                  cardData.name ?? '',
                ),
              ),
            ),
            pw.Positioned(
              bottom: 80,
              left: 20,
              child: customText2(
                cardData.sangha ?? '',
              ),
            ),
            pw.Positioned(
              bottom: 70,
              left: 20,
              child: customText2(
                "${cardData.devoteeCode}",
              ),
            ),
            // pw.Positioned(
            //   bottom: 70,
            //   left: 20,
            //   child: pw.Container(
            //     height: 100,
            //     child: SfBarcodeGenerator(
            //       value: cardData.devoteeCode.toString(),
            //       symbology: QRCode(),
            //       showValue: false,
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }

    // pw.Widget buildCard(pw.Context context, DevoteeModel cardData) {
    //   return pw.Container(
    //     height: 4.4 * PIXEL_PER_INCH,
    //     width: 2.7 * PIXEL_PER_INCH,
    //     margin: const pw.EdgeInsets.all(8),
    //     padding: const pw.EdgeInsets.all(8),
    //     decoration: pw.BoxDecoration(
    //       border: pw.Border.all(color: PdfColors.black),
    //     ),
    //     child: containerImage,
    //   );
    // }

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
