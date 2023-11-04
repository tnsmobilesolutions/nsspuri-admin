// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPaliMultiple.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaTableRow.dart';

class PaliaListBodyPage extends StatefulWidget {
  PaliaListBodyPage({Key? key, required this.year}) : super(key: key);
  String year;

  @override
  State<PaliaListBodyPage> createState() => _PaliaListBodyPageState();
}

class _PaliaListBodyPageState extends State<PaliaListBodyPage> {
  List<VaktaModel>? allPaliaList;
  List<String> selectedPalia = [];
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
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MultipleEditPali(
                    docIds: selectedPalia,
                  )),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Color(0XFF3f51b5),
                  ),
                  foregroundColor: const Color(0XFF3f51b5),
                ),
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
                        width: 1.0,
                        color: Color(0XFF3f51b5),
                      ),
                      foregroundColor: const Color(0XFF3f51b5),
                    ),
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
                                          'Total Record - ${allPaliaList?.length}'),
                                      pw.Text(
                                          'Total Pranami - ${allPaliaList?.length} × 1101 = ${(allPaliaList != null ? (allPaliaList?.length)! : 0) * (1101)}'),
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
                                printSearchheadingText('Palia Name'),
                                printSearchheadingText('Sangha'),
                                printSearchheadingText('pali Date'),
                              ]),
                              pw.Divider(thickness: 0.5),
                              pw.ListView.builder(
                                itemCount: allPaliaList != null
                                    ? allPaliaList!.length
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
                                              '${allPaliaList?[index].name}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${allPaliaList?[index].sangha}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${allPaliaList?[index].paaliDate}',
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
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Checkbox(
                      value: allCheck ?? false,
                      onChanged: (value) async {
                        var alldata =
                            await PaliaAPI().fetchAllByYearPalias(widget.year);

                        setState(() {
                          allCheck = value!;

                          for (var e in alldata) {
                            if (allCheck == true) {
                              // editpaliDate = true;
                              if (!selectedPalia.contains(e)) {
                                selectedPalia.add(e.docId.toString());
                              }
                            } else if (allCheck == false) {
                              editpaliDate = false;
                              selectedPalia.remove(e.docId);

                              if (selectedPalia == []) {
                                setState(() {});
                              }
                            }
                          }
                        });
                      }),
                )),
                headingText('କ୍ରମିକ ନଂ'),
                headingText('ପାଳିଆ ନାମ'),
                headingText('ସଂଘ'),
                headingText('ପାଳି ତାରିଖ'),
                if (showMenu == true) headingText('View'),
                if (showMenu == true) headingText('Edit'),
                if (showMenu == true) headingText('Delete'),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          FutureBuilder(
            future: PaliaAPI().fetchAllByYearPalias(widget.year),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              allPaliaList = snapshot.data;
              if (snapshot.hasError) {
                return const Text('SNAPSHOT ERROR');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Table firebase Data
                      return PaliaTableRow(
                        showMenu: showMenu,
                        slNo: index + 1,
                        allCheck: allCheck,
                        paliaDetails: snapshot.data[index],
                        isCheckedBoolValue: (isCheckedValue) {
                          // checkedValue = isCheckedValuee;
                          if (isCheckedValue == true) {
                            editpaliDate = true;
                            if (!selectedPalia
                                .contains(snapshot.data[index].docId)) {
                              selectedPalia.add(snapshot.data[index].docId);
                            }
                          } else {
                            selectedPalia.remove(snapshot.data[index].docId);
                          }
                        },
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
