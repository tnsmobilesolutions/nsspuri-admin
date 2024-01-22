import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/viewDevotee/constants.dart';
import 'package:sdp/screen/viewDevotee/delegate_back.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PreviewDelegateTab extends StatefulWidget {
  final DevoteeModel devoteeDetails;

  const PreviewDelegateTab({Key? key, required this.devoteeDetails})
      : super(key: key);

  @override
  _PreviewDelegateTabState createState() => _PreviewDelegateTabState();
}

class _PreviewDelegateTabState extends State<PreviewDelegateTab> {
  final con = FlipCardController();
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

  Text buildSanghaText(String? sanghaName) {
    double fontSize = 10;

    if (sanghaName != null) {
      int nameLength = sanghaName.length;

      if (nameLength > 15) {
        fontSize = 7;
      } else if (nameLength < 5) {
        fontSize = 14.0;
      }
    }

    return Text(
      _toPascalCase(sanghaName ?? ''),
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  AssetImage getCardImage(DevoteeModel devotee) {
    if (devotee.isGuest == true)
      return const AssetImage('assets/images/guest.png');
    if (devotee.isSpeciallyAbled == true)
      return const AssetImage('assets/images/old.png');
    if (devotee.isOrganizer == true)
      return const AssetImage('assets/images/organiser.png');

    if (devotee.ageGroup != "") {
      if (devotee.ageGroup == "Child")
        return const AssetImage('assets/images/child.png');

      if (devotee.ageGroup == "Adult") {
        if (devotee.gender == "Male") {
          return const AssetImage('assets/images/bhai.png');
        }
        if (devotee.gender == "Female") {
          return const AssetImage('assets/images/maa.png');
        }
      }

      if (devotee.ageGroup == "Elder")
        return const AssetImage('assets/images/old.png');
    }

    if (devotee.dob?.isNotEmpty == true && devotee.dob != null) {
      int age = calculateAge(DateTime.parse(devotee.dob.toString()));
      if (age <= teenAgeLimit)
        return const AssetImage('assets/images/child.png');
      if (age >= seniorCitizenAgeLimit)
        return const AssetImage('assets/images/bhai.png');
    }

    if (devotee.gender == "Male")
      return const AssetImage('assets/images/bhai.png');
    if (devotee.gender == "Female")
      return const AssetImage('assets/images/maa.png');

    return const AssetImage('assets/images/bhai.png');
  }

  AssetImage _getFemaleImage(int age) {
    if (age < 18) {
      return const AssetImage('assets/images/girl.png');
    } else {
      return const AssetImage('assets/images/woman.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final devotees = widget.devoteeDetails;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
            ),
            child: Column(
              children: [
                FlipCard(
                  rotateSide: RotateSide.right,
                  onTapFlipping: true,
                  axis: FlipAxis.vertical,
                  controller: con,
                  backWidget: CardFlip(color: getColorByDevotee(devotees)),
                  frontWidget: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        height: 324,
                        width: 198,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: getCardImage(devotees)),
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
                              Expanded(
                                flex: 5,
                                child: Container(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: widget.devoteeDetails
                                                          .bloodGroup ==
                                                      "Don't know" ||
                                                  widget.devoteeDetails
                                                          .bloodGroup ==
                                                      null
                                              ? Container(
                                                  width: 45,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                )
                                              : Center(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 50,
                                                        height: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: AssetImage(
                                                                'assets/images/blood.png'),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 7,
                                                        left: 4,
                                                        child: SizedBox(
                                                          width: 45,
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                              "${widget.devoteeDetails.bloodGroup}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 10,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                        child: Center(
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              // Image in the center
                                              SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image(
                                                  image: widget.devoteeDetails
                                                                  .profilePhotoUrl !=
                                                              null &&
                                                          widget
                                                              .devoteeDetails
                                                              .profilePhotoUrl!
                                                              .isNotEmpty
                                                      ? NetworkImage(widget
                                                          .devoteeDetails
                                                          .profilePhotoUrl
                                                          .toString())
                                                      : const AssetImage(
                                                              'assets/images/profile.jpeg')
                                                          as ImageProvider<
                                                              Object>,
                                                ),
                                              ),
                                              // "PAID" text beside the image
                                              if (widget.devoteeDetails
                                                          .status ==
                                                      "paid" ||
                                                  widget.devoteeDetails
                                                          .status ==
                                                      "printed")
                                                Positioned(
                                                  top: 7,
                                                  left:
                                                      80, // Adjust the left position as needed
                                                  child: Transform.rotate(
                                                    angle: 12,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                44, 7, 209),
                                                            width: 4,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Text(
                                                            'PAID',
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      44,
                                                                      7,
                                                                      209),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Expanded(
                                flex: 1,
                                child: widget.devoteeDetails.name != null
                                    ? Text(
                                        _toPascalCase(widget.devoteeDetails.name
                                            .toString()),
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const Text(""),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: buildSanghaText(widget
                                                    .devoteeDetails.sangha)),
                                            Expanded(
                                              flex: 1,
                                              child: widget.devoteeDetails
                                                          .devoteeCode !=
                                                      null
                                                  ? Text(
                                                      _toPascalCase(widget
                                                          .devoteeDetails
                                                          .devoteeCode
                                                          .toString()),
                                                      style: const TextStyle(
                                                        color:
                                                            Colors.deepOrange,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  : const Text(""),
                                            ),
                                            const SizedBox(
                                              height: 10,
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
                                        padding: const EdgeInsets.all(5),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: SfBarcodeGenerator(
                                          value: widget
                                              .devoteeDetails.devoteeCode
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
