import 'package:flutter/material.dart';

class customCircleAvtar extends StatelessWidget {
  customCircleAvtar({super.key, required this.imageURL});
  String imageURL;

  @override
  Widget build(
    BuildContext context,
  ) {
    return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: InkWell(
          onTap: (() {}),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/nsspuridelegate-dev.appspot.com/o/3d%20profile%20icon.png?alt=media&token=9e216c52-8517-4983-a695-9f0741d6dd02",
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 50,
                right: 0,
                left: 90,
                child: Icon(Icons.camera_alt, color: Colors.deepOrange),
              ),
            ],
          ),
        ));
  }
}
