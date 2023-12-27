import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';

import 'package:flutter/services.dart';

class customCircleAvtar extends StatefulWidget {
  customCircleAvtar({super.key, required this.imageURL});
  String imageURL;

  @override
  State<customCircleAvtar> createState() => _customCircleAvtarState();
}

class _customCircleAvtarState extends State<customCircleAvtar> {
  List<int>? selectedimage;

  Uint8List? imageasbytes;

  File? imagefile;

  String? imageName;

  bool isAvailable = false;

  webPicker() async {
    // Create an instance of FileUploadInputElement
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final inputImageFile = uploadInput.files![0];
      const maxSizeBytes = 1 * 1024 * 1024;

      if (!inputImageFile.type.toLowerCase().startsWith('image/')) {
        print("Invalid format !");
        // Message().customMessage(context, MediaQuery.of(context).size.width,
        //     "Invalid format !", CustomColor.errorColor);
        return;
      }

      if (inputImageFile.size > maxSizeBytes) {
        // Message().customMessage(
        //     context,
        //     MediaQuery.of(context).size.width,
        //     "File size exceeds the limit (1MB). Please choose a smaller file.",
        //     CustomColor.actionColor);
        print(
            'File size exceeds the limit (1MB). Please choose a smaller file.');
        return;
      }

      imageName = inputImageFile.name;
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          imageasbytes = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          selectedimage = imageasbytes;
          isAvailable = true;
          imagefile = inputImageFile;
        });
      });
      reader.readAsDataUrl(inputImageFile);
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: InkWell(
          onTap: () {
            webPicker();
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 80,
                right: 0,
                left: 90,
                child: InkWell(
                  child: Icon(Icons.camera_alt, color: Colors.deepOrange),
                  onTap: (() {
                    webPicker();
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
