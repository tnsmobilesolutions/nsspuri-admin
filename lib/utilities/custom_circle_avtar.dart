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
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/nsspuridelegate-dev.appspot.com/o/3d%20profile%20icon.png?alt=media&token=9e216c52-8517-4983-a695-9f0741d6dd02",
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
