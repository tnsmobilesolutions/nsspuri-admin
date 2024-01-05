// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaTableRow.dart';

class PaliaListBodyPage extends StatefulWidget {
  PaliaListBodyPage(
      {Key? key,
      required this.status,
      required this.pageFrom,
      this.searchValue,
      this.searchBy})
      : super(key: key);
  String status;
  String pageFrom;
  String? searchValue;
  String? searchBy;

  @override
  State<PaliaListBodyPage> createState() => _PaliaListBodyPageState();
}

class _PaliaListBodyPageState extends State<PaliaListBodyPage> {
  List<DevoteeModel> allPaliaList = [];

  bool checkedValue = false;
  bool? allCheck;
  bool editpaliDate = false;

  bool showMenu = false;
  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  pw.Expanded printSearchheadingText(String text) {
    return pw.Expanded(
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 20,
          // font: baloobhainaheading,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side:
                        const BorderSide(width: 1.5, color: Colors.deepOrange),
                    foregroundColor: Colors.black),
                onPressed: () {
                  setState(() {
                    showMenu = !showMenu;
                  });
                },
                child: const Text('Show Action Menu'),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.5,
                          color: Colors.deepOrange,
                        ),
                        foregroundColor: Colors.black),
                    onPressed: () async {
                      final baloobhaina2font =
                          await PdfGoogleFonts.balooBhaina2Regular();
                      final doc = pw.Document();
                      doc.addPage(
                        pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            return pw.Column(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      'ଜୟଗୁରୁ',
                                      style: pw.TextStyle(
                                        decoration: pw.TextDecoration.underline,
                                        font: baloobhaina2font,
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ]),
                              pw.Column(
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                          'Total Record - ${allPaliaList.length}'),
                                      pw.Text(
                                          'Total Pranami - ${allPaliaList.length} × 1101 = ${(allPaliaList.isNotEmpty ? (allPaliaList.length) : 0) * (1101)}'),
                                    ],
                                  )
                                ],
                              ),
                              pw.Divider(),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: []),
                              pw.SizedBox(height: 20),
                              pw.Row(children: [
                                printSearchheadingText('Sl no.'),
                                printSearchheadingText('Devotee Name'),
                                printSearchheadingText('Devotee Code'),
                                printSearchheadingText('Sangha'),
                                printSearchheadingText('DOB'),
                                printSearchheadingText('Status'),
                              ]),
                              pw.Divider(thickness: 0.5),
                              pw.ListView.builder(
                                itemCount: allPaliaList.isNotEmpty
                                    ? allPaliaList.length
                                    : 0,
                                itemBuilder: (pw.Context context, int index) {
                                  return pw.Column(
                                    children: [
                                      pw.Row(
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              (index + 1).toString(),
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${allPaliaList[index].name}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${allPaliaList[index].devoteeCode}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${allPaliaList[index].sangha}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${allPaliaList[index].dob}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.Divider(
                                        thickness: 0.5,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ]);
                          },
                        ),
                      ); //
                      PdfPreview(
                        build: (format) => doc.save(),
                      );
                      await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => doc.save());
                    },
                    child: const Text('Print')),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                headingText('Sl No.'),
                headingText('Profile Image'),
                headingText('Devotee Name'),
                headingText('Devotee Code'),
                headingText('Sangha'),
                headingText('DOB'),
                headingText('Status'),
                if (showMenu == true) headingText('View'),
                if (showMenu == true) headingText('Edit'),
                // if (showMenu == true) headingText('Delete'),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          FutureBuilder(
            future: (widget.status == "allDevotee" &&
                    widget.pageFrom == "Dashboard")
                ? GetDevoteeAPI().allDevotee()
                : (widget.status != "allDevotee" &&
                        widget.pageFrom == "Dashboard")
                    ? GetDevoteeAPI().searchDevotee(widget.status, "status")
                    : (widget.pageFrom == "Search")
                        ? GetDevoteeAPI().advanceSearchDevotee(
                            widget.searchValue.toString(),
                            widget.searchBy.toString(),
                          )
                        : null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text('SNAPSHOT ERROR');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                allPaliaList = snapshot.data["data"];
                return Flexible(
                  child: ListView.builder(
                    itemCount: allPaliaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Table firebase Data
                      return PaliaTableRow(
                        showMenu: showMenu,
                        slNo: index + 1,
                        devoteeDetails: allPaliaList[index],
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
