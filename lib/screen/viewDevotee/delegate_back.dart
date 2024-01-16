import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

// ignore: must_be_immutable
class CardFlip extends StatefulWidget {
  CardFlip({super.key, required this.color});
  Color color;

  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> {
  late PageController controller;
  GlobalKey<PageContainerState> key = GlobalKey();

  String _toCamelCase(String input) {
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

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: SizedBox(
          height: 550,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 194, 202, 218),
                    spreadRadius: 4,
                    blurRadius: 8,
                  ),
                ],
                border: Border.all(
                    width: 10, color: const Color.fromARGB(255, 233, 233, 233)),
                color: widget.color,
                borderRadius: const BorderRadius.all(Radius.circular(35))),
            child: PageView.builder(
              // shrinkWrap: true,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                // DevoteeModel singledevotee =
                //     DevoteeModel.fromMap(devotees[index]);
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        width: 400,
                        height: 50,

                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'ବିଧି ନିଷେଧ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        // Background color of the container
                      ),
                    ),
                    Container(
                      height: 410,
                      width: 400,
                      decoration: BoxDecoration(
                        color: widget.color,
                      ),
                      // ignore: prefer_const_constructors
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 1, left: 8, right: 8, bottom: 16),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Divider(
                              color: Colors.white,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '୧.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'ସମ୍ମିଳନୀରେ ସର୍ବଦା ଶୁଦ୍ଧପୂତ ଓ ପବିତ୍ର ଭାବରେ ଚଳିବେ| କେହି ମାଦକ ଦ୍ରବ୍ୟ ସେବନ କରିବେ ନାହିଁ|',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '୨.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'ସମ୍ମିଳନୀ ପରିସର ମଧ୍ୟରେ ପରନିନ୍ଦା, ପରଚର୍ଚ୍ଚା ଓ ଅବାନ୍ତର ଆଲୋଚନା କରିବେ ନିଷିଦ୍ଧ|',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '୩.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'ମାତୃଜାତିର ସମ୍ମାନରେ ବାଧା ପ୍ରଦାନ କରିବେ ନାହିଁ|',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '૪.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'କୌଣସି ଆଦର୍ଶ ହାନୀକାର କାର୍ଯ୍ୟ ଦେଖିଲେ ବା ଶୁଣିଲେ ସମ୍ମିଳନୀ କାର୍ଯ୍ୟାଳୟରେ ଜଣାଇବେ|',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '୫.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'ସୁନାଗହଣା ଆଦି ମୂଲ୍ୟବାନ ଦ୍ରବ୍ୟ ସାଙ୍ଗରେ ଆଣିବେ ନାହଁ|',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '୬.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'କ୍ୟାମ୍ପରେ ଟେପ ରେକର୍ଡର ବ୍ୟବହାର ନିଷିଦ୍ଧ|',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Container(
                      height: 50,
                      width: 400,
                      child: const Center(
                          child: Text(
                        'ହଜିଯାଇଥିଲେ ଯୋଗାଯୋଗ କରନ୍ତୁ 7738261091',
                        style: TextStyle(color: Colors.white),
                      )),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
