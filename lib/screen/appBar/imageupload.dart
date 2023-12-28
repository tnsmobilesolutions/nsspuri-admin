import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sdp/utilities/custom_circle_avtar.dart';

class UploadCarousalImage extends StatefulWidget {
  const UploadCarousalImage({
    Key? key,
    required this.onImageSelected,
    this.fileName,
    this.selectedImage,
  }) : super(key: key);

  final void Function(Map<String, dynamic>?) onImageSelected;
  final String? fileName;
  final List<int>? selectedImage;

  @override
  _UploadCarousalImageState createState() => _UploadCarousalImageState();
}

class _UploadCarousalImageState extends State<UploadCarousalImage> {
  Map<String, dynamic>? image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      final List<int> bytes = await pickedFile.readAsBytes();
      setState(() {
        image = {'selectedImage': bytes};
      });
      widget.onImageSelected(image);
    }
  }

  // Widget buildSelectImageButton() {
  //   return TextButton.icon(
  //     onPressed: () async {
  //       await _getImage(ImageSource.camera);
  //     },
  //     icon: const Icon(Icons.camera),
  //     label: customCircleAvatarWidget(),
  //   );
  // }

  Widget customCircleAvatarWidget() {
    return image?['selectedImage'] != null
        ? Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.blueAccent,
                width: 2.0,
              ),
            ),
            child: ClipOval(
              child: Center(child: Image.memory(image?['selectedImage'])),
            ),
          )
        : Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            child: ClipOval(
              child: Center(
                child: IconButton(
                    onPressed: () {
                      _getImage(ImageSource.camera);
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                    )),
              ),
            ),
          );
  }

  Widget buildRemoveImageButton(double screenWidth) {
    return IconButton(
      onPressed: () {
        setState(() {
          widget.onImageSelected(null);
          image?['selectedImage'] = null;
        });
      },
      icon: const Icon(Icons.delete),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload',
          style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.selectedImage == null)
              customCircleAvatarWidget()
            else
              customCircleAvatarWidget(),
            if (widget.selectedImage != null)
              buildRemoveImageButton(screenWidth),
          ],
        ),
      ],
    );
  }
}
