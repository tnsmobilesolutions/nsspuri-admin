import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfileImage extends StatefulWidget {
  const UploadProfileImage({
    Key? key,
    required this.onImageSelected,
    this.fileName,
    this.selectedImage,
  }) : super(key: key);

  final void Function(Map<String, dynamic>?, XFile?) onImageSelected;
  final String? fileName;
  final List<int>? selectedImage;

  @override
  _UploadProfileImageState createState() => _UploadProfileImageState();
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  Map<String, dynamic>? image;
  XFile? pickImage;
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final List<int> bytes = await pickedFile.readAsBytes();
      setState(() {
        image = {'selectedImage': bytes};
        pickImage = pickedFile;
      });
      widget.onImageSelected(image, pickImage);
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
              child: Center(
                child: Image.memory(image?['selectedImage']),
              ),
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
          widget.onImageSelected(null, null);
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
