import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:sdp/constant/print_image.dart';
import 'package:sdp/model/devotee_model.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:sdp/screen/viewDevotee/constants.dart';
import 'package:sdp/screen/viewDevotee/delegate_back.dart';
import 'package:sdp/utilities/network_helper.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class DownloadImagePage extends StatefulWidget {
  DownloadImagePage({Key? key, this.devoteeData}) : super(key: key);
  List<DevoteeModel>? devoteeData;

  @override
  State<DownloadImagePage> createState() => _DownloadImagePageState();
}

class _DownloadImagePageState extends State<DownloadImagePage> {
  final con = FlipCardController();
  bool? downloading;
  final GlobalKey _globalKey = GlobalKey();

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

  // pw.Expanded printSearchheadingText(String text) {
  //   return pw.Expanded(
  //     child: pw.Text(
  //       text,
  //       textAlign: pw.TextAlign.center,
  //       style: pw.TextStyle(
  //         fontSize: 20,
  //         // font: baloobhainaheading,
  //         fontWeight: pw.FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

  AssetImage getCardImage(DevoteeModel? devotee) {
    if (devotee?.isGuest == true) {
      return const AssetImage('assets/images/guest.png');
    }
    if (devotee?.isSpeciallyAbled == true) {
      return const AssetImage('assets/images/old.png');
    }
    if (devotee?.isOrganizer == true) {
      return const AssetImage('assets/images/organiser.png');
    }

    if (devotee?.ageGroup != "") {
      if (devotee?.ageGroup == "Child") {
        return const AssetImage('assets/images/child.png');
      }

      if (devotee?.ageGroup == "Adult") {
        if (devotee?.gender == "Male") {
          return const AssetImage('assets/images/bhai.png');
        }
        if (devotee?.gender == "Female") {
          return const AssetImage('assets/images/maa.png');
        }
      }

      if (devotee?.ageGroup == "Elder") {
        return const AssetImage('assets/images/old.png');
      }
    }

    if (devotee?.dob?.isNotEmpty == true && devotee?.dob != null) {
      int age = calculateAge(DateTime.parse(devotee?.dob ?? ''));
      if (age <= teenAgeLimit) {
        return const AssetImage('assets/images/child.png');
      }
      if (age >= seniorCitizenAgeLimit) {
        return const AssetImage('assets/images/old.png');
      }
    }

    if (devotee?.gender == "Male") {
      return const AssetImage('assets/images/bhai.png');
    }
    if (devotee?.gender == "Female") {
      return const AssetImage('assets/images/maa.png');
    }

    return const AssetImage('assets/images/bhai.png');
  }

  AssetImage _getFemaleImage(int age) {
    if (age < 18) {
      return const AssetImage('assets/images/girl.png');
    } else {
      return const AssetImage('assets/images/woman.png');
    }
  }

  // Future<void> _downloadImage() async {
  //   Uint8List? capturedImage = await screenshotController.capture();

  //   // Convert the Uint8List to a base64-encoded string
  //   String base64Image = base64Encode(capturedImage!);

  //   // Create a data URL for the image
  //   String dataUrl = 'data:image/png;base64,$base64Image';

  //   // Create a temporary anchor element
  //   html.AnchorElement(href: dataUrl)
  //     ..target = 'blank'
  //     ..download = 'devoteecard_screenshot.png'
  //     ..click();
  // }
  // Future<void> _downloadImage() async {
  //   Uint8List? capturedImage = await screenshotController.capture();

  //   // Check if the capturedImage is not null
  //   if (capturedImage != null) {
  //     // Convert the Uint8List to a base64-encoded string
  //     String base64Image = base64Encode(capturedImage);

  //     // Create a data URL for the image
  //     String dataUrl = 'data:image/png;base64,$base64Image';

  //     // Create a temporary anchor element
  //     final anchor = html.AnchorElement(href: dataUrl)
  //       ..target = 'blank'
  //       ..download = 'devoteecard_screenshot.png';

  //     // Attach the anchor element to the DOM
  //     html.document.body?.append(anchor);

  //     // Simulate a click on the anchor element
  //     anchor.click();

  //     // Remove the anchor element from the DOM
  //     anchor.remove();
  //   }
  // }
  Future<void> _downloadWidget() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    html.Blob blob = html.Blob([pngBytes]);
    String url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'screenshot.png' // Specify the filename
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  // Future<void> _downloadImage() async {
  //   setState(() {
  //     downloading = true;
  //   });

  //   screenshotController
  //       .capture(delay: Duration(milliseconds: 10))
  //       .then((Uint8List? capturedImage) async {
  //     // Download the image using image_downloader_web
  //     await WebImageDownloader.downloadImageFromUInt8List(
  //         uInt8List: capturedImage!,
  //         name: 'captured_image',
  //         imageType: ImageType.png,
  //         imageQuality: 5);

  //     setState(() {
  //       downloading = false;
  //     });
  //   }).catchError((onError) {
  //     print(onError);
  //     setState(() {
  //       downloading = false;
  //     });
  //   });
  // }

  Widget buildSanghaText(String? sanghaName) {
    double fontSize = 17;
    if (sanghaName != null) {
      int nameLength = sanghaName.length;
      if (nameLength > 16) {
        fontSize = 13;
      } else {
        fontSize = 17;
      }
    }
    return Text(
      //"123456789012345678901234567890",
      _toPascalCase(sanghaName ?? ''),
      // overflow: TextOverflow.clip,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildNameText(String? devoteeName) {
    double fontSize = 17;
    if (devoteeName != null) {
      int nameLength = devoteeName.length;
      if (nameLength > 22) {
        fontSize = 10;
      } else {
        fontSize = 15;
      }
    }
    return Text(
      _toPascalCase(devoteeName ?? ''),
      style: TextStyle(
        color: Colors.deepOrange,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Image Page'),
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: GridView.builder(
          itemCount: widget.devoteeData?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, childAspectRatio: .7),
          itemBuilder: (BuildContext context, int index) {
            return FlipCard(
              rotateSide: RotateSide.right,
              onTapFlipping: true,
              axis: FlipAxis.vertical,
              controller: con,
              backWidget: CardFlip(color: Colors.white),
              frontWidget: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    height: 324,
                    width: 198,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                            image: getCardImage(widget.devoteeData?[index])),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 194, 202, 218),
                          ),
                        ],
                        border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 233, 233, 233),
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child: Column(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: SizedBox(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: widget.devoteeData?[index]
                                                    .bloodGroup ==
                                                "Don't know" ||
                                            widget.devoteeData?[index]
                                                    .bloodGroup ==
                                                null
                                        ? Container(
                                            width: 90,
                                            height: 70,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                            ),
                                          )
                                        : Center(
                                            child: Stack(
                                              children: [
                                                const SizedBox(
                                                  height: 70,
                                                  width: 90,
                                                  child: Center(
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/images/blood.png'),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 25,
                                                  left: 22,
                                                  child: SizedBox(
                                                    width: 45,
                                                    height: 40,
                                                    child: Center(
                                                      child: Text(
                                                        "${widget.devoteeData?[index].bloodGroup}",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    // Return an empty Container if the condition is false
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: getColorByDevotee(
                                              widget.devoteeData?[index]),
                                          backgroundImage: widget
                                                      .devoteeData?[index]
                                                      .profilePhotoUrl !=
                                                  null
                                              ? NetworkImage(widget
                                                      .devoteeData?[index]
                                                      .profilePhotoUrl ??
                                                  '')
                                              : const AssetImage(
                                                      'assets/images/profile.jpeg')
                                                  as ImageProvider<Object>,
                                        ),
                                      ),
                                      if (NetworkHelper()
                                                  .getCurrentDevotee
                                                  ?.role !=
                                              "Admin" &&
                                          NetworkHelper()
                                                  .getCurrentDevotee
                                                  ?.role !=
                                              "SuperAdmin" &&
                                          NetworkHelper()
                                                  .getCurrentDevotee
                                                  ?.role !=
                                              "Approver")
                                        Positioned(
                                          top: 50,
                                          left: 0,
                                          child: Transform.rotate(
                                            angle: 12,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 44, 7, 209),
                                                        width: 4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'Preview',
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 44, 7, 209),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Expanded(
                              flex: 1,
                              child: buildNameText(
                                  widget.devoteeData?[index].name)),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: buildSanghaText(widget
                                                .devoteeData?[index].sangha)),
                                        widget.devoteeData?[index].sangha !=
                                                    null &&
                                                (widget.devoteeData?[index]
                                                        .sangha!.length)! >
                                                    18
                                            ? const SizedBox(height: 20)
                                            : const SizedBox(height: 10),
                                        Expanded(
                                          flex: 5,
                                          child: widget.devoteeData?[index]
                                                      .devoteeCode !=
                                                  null
                                              ? Text(
                                                  _toPascalCase(
                                                      "${widget.devoteeData?[index].devoteeCode}"),
                                                  style: const TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const Text(""),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    height: 168,
                                    width: 168,
                                    child: SfBarcodeGenerator(
                                      value: widget
                                          .devoteeData?[index].devoteeCode
                                          .toString(),
                                      symbology: QRCode(),
                                      showValue: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //   DisplayPdf(context);
      //     //_downloadWidget();
      //   },
      //   child: Icon(Icons.download),
      // ),
    );
  }
}
