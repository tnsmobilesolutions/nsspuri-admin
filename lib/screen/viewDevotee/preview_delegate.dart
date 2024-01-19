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

    // Adjust the font size based on the length of the sanghaName
    if (sanghaName != null) {
      int nameLength = sanghaName.length;

      if (nameLength > 15) {
        fontSize = 8; // Reduce font size for longer names
      } else if (nameLength < 5) {
        fontSize = 14.0; // Increase font size for shorter names
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
                        height: 422,
                        width: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 194, 202, 218),
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          border: Border.all(
                            width: 3,
                            color: const Color.fromARGB(255, 233, 233, 233),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(.0),
                          child: Column(
                            children: [
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: getColorByDevotee(devotees),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        'DELEGATE CARD',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 370,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 20,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: ListView.separated(
                                                itemCount: 19,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SvgPicture.asset(
                                                    'assets/images/3.svg',
                                                    color: getColorByDevotee(
                                                        devotees),
                                                    height: 15,
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  // This widget will be used as a separator between items.
                                                  // You can adjust the size and appearance of the separator here.
                                                  return const SizedBox(
                                                      height:
                                                          3.6); // Adjust the height as needed.
                                                },
                                              ),
                                            ),
                                            Expanded(
                                                flex: 8,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            child: Image.asset(
                                                              'assets/images/nsslogo.png',
                                                              scale: 50,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            child: const Center(
                                                              child: Text(
                                                                'JAYAGURU',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black // Text color
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            child: Image.asset(
                                                              'assets/images/Subtract.png',
                                                              scale: 120,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Text(
                                                      'NILACHALA SARASWATA SANGHA, PURI',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .deepOrange // Text color
                                                          ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      '73RD UTKALA PRADESHIKA',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors
                                                              .black // Text color
                                                          ),
                                                    ),
                                                    const Text(
                                                      'BHAKTA SAMMILANI, PUNE - 2024',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Colors
                                                              .black // Text color
                                                          ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                              child: widget.devoteeDetails
                                                                              .bloodGroup ==
                                                                          "Don't know" ||
                                                                      widget.devoteeDetails
                                                                              .bloodGroup ==
                                                                          null
                                                                  ? Container(
                                                                      width: 60,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                      ),
                                                                    )
                                                                  : Center(
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              shape: BoxShape.rectangle,
                                                                              image: DecorationImage(
                                                                                fit: BoxFit.fill,
                                                                                image: AssetImage('assets/images/blood.png'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                            top:
                                                                                7,
                                                                            left:
                                                                                0,
                                                                            child:
                                                                                SizedBox(
                                                                              width: 60,
                                                                              height: 50,
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "${widget.devoteeDetails.bloodGroup}",
                                                                                  style: const TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                                    fontWeight: FontWeight.bold,
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
                                                            flex: 9,
                                                            child: Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Positioned(
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius:
                                                                        55, // Adjust the radius as needed
                                                                    backgroundColor:
                                                                        getColorByDevotee(
                                                                            devotees),
                                                                    backgroundImage: widget.devoteeDetails.profilePhotoUrl !=
                                                                                null &&
                                                                            widget
                                                                                .devoteeDetails.profilePhotoUrl!.isNotEmpty
                                                                        ? NetworkImage(widget
                                                                            .devoteeDetails
                                                                            .profilePhotoUrl
                                                                            .toString())
                                                                        : const AssetImage('assets/images/profile.jpeg')
                                                                            as ImageProvider<Object>,
                                                                  ),
                                                                ),
                                                                // if (widget.devoteeDetails
                                                                //             .status ==
                                                                //         "paid" ||
                                                                //     widget.devoteeDetails
                                                                //             .status ==
                                                                //         "printed")
                                                                //   Positioned(
                                                                //     top: 50,
                                                                //     left: 105,
                                                                //     child: Transform
                                                                //         .rotate(
                                                                //       angle: 12,
                                                                //       child:
                                                                //           Padding(
                                                                //         padding: const EdgeInsets
                                                                //             .all(
                                                                //             4.0),
                                                                //         child:
                                                                //             Container(
                                                                //           decoration: BoxDecoration(
                                                                //               border: Border.all(color: const Color.fromARGB(255, 44, 7, 209), width: 4),
                                                                //               borderRadius: BorderRadius.circular(4)),
                                                                //           child:
                                                                //               const Padding(
                                                                //             padding:
                                                                //                 EdgeInsets.all(4.0),
                                                                //             child:
                                                                //                 Text(
                                                                //               'PAID',
                                                                //               style: TextStyle(
                                                                //                 fontSize: 30.0,
                                                                //                 fontWeight: FontWeight.bold,
                                                                //                 color: Color.fromARGB(255, 44, 7, 209),
                                                                //               ),
                                                                //             ),
                                                                //           ),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    widget.devoteeDetails
                                                                .name !=
                                                            null
                                                        ? Text(
                                                            _toPascalCase(widget
                                                                .devoteeDetails
                                                                .name
                                                                .toString()),
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .deepOrange,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        : const Text(""),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Flexible(
                                                            flex: 2,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: buildSanghaText(widget
                                                                        .devoteeDetails
                                                                        .sangha)),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: widget
                                                                              .devoteeDetails
                                                                              .devoteeCode !=
                                                                          null
                                                                      ? Text(
                                                                          _toPascalCase(widget
                                                                              .devoteeDetails
                                                                              .devoteeCode
                                                                              .toString()),
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.deepOrange,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        )
                                                                      : const Text(
                                                                          ""),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    "Sri Sri Thakura Charanasrita",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            7,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      decoration: const BoxDecoration(
                                                                          image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/images/Naresh.jpeg"),
                                                                    scale: 18,
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                  ))),
                                                                ),
                                                                const Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    'Secretary',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Flexible(
                                                            flex: 3,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  4.8,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  4.8,
                                                              child:
                                                                  SfBarcodeGenerator(
                                                                value: widget
                                                                    .devoteeDetails
                                                                    .devoteeCode
                                                                    .toString(),
                                                                symbology:
                                                                    QRCode(),
                                                                showValue:
                                                                    false,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Expanded(
                                              child: ListView.separated(
                                                itemCount: 20,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SvgPicture.asset(
                                                    'assets/images/3.svg',
                                                    color: getColorByDevotee(
                                                        devotees),
                                                    height: 15,
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  // This widget will be used as a separator between items.
                                                  // You can adjust the size and appearance of the separator here.
                                                  return const SizedBox(
                                                      height:
                                                          3.6); // Adjust the height as needed.
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 4),
                                          child: GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  12, // Number of columns
                                              crossAxisSpacing:
                                                  4.0, // Adjust the spacing between columns
                                              mainAxisSpacing:
                                                  8.0, // Adjust the spacing between rows
                                            ),
                                            itemCount:
                                                12, // Change this number based on your actual requirement
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return SvgPicture.asset(
                                                'assets/images/3.svg',
                                                height: 15,
                                                color:
                                                    getColorByDevotee(devotees),
                                              );
                                            },
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
