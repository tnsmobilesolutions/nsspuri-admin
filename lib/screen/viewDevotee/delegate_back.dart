import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

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
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SizedBox(
          child: Container(
            height: 324,
            width: 198,
            decoration: BoxDecoration(
                color: widget.color,
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
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                        ),
                        color: widget.color,
                      ),
                      height: 30,

                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            'ବିଧି ନିଷେଧ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      // Background color of the container
                    ),
                    // ignore: prefer_const_constructors
                    Padding(
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'ସମ୍ମିଳନୀରେ ସର୍ବଦା ଶୁଦ୍ଧପୂତ ଓ ପବିତ୍ର ଭାବରେ ଚଳିବେ| କେହି ମାଦକ ଦ୍ରବ୍ୟ ସେବନ କରିବେ ନାହିଁ|',
                                  style: TextStyle(
                                    fontSize: 10,
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'ସମ୍ମିଳନୀ ପରିସର ମଧ୍ୟରେ ପରନିନ୍ଦା, ପରଚର୍ଚ୍ଚା ଓ ଅବାନ୍ତର ଆଲୋଚନା କରିବେ ନିଷିଦ୍ଧ|',
                                  style: TextStyle(
                                    fontSize: 10,
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'ମାତୃଜାତିର ସମ୍ମାନରେ ବାଧା ପ୍ରଦାନ କରିବେ ନାହିଁ|',
                                  style: TextStyle(
                                    fontSize: 10,
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'କୌଣସି ଆଦର୍ଶ ହାନୀକାର କାର୍ଯ୍ୟ ଦେଖିଲେ ବା ଶୁଣିଲେ ସମ୍ମିଳନୀ କାର୍ଯ୍ୟାଳୟରେ ଜଣାଇବେ|',
                                  style: TextStyle(
                                    fontSize: 10,
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'ସୁନାଗହଣା ଆଦି ମୂଲ୍ୟବାନ ଦ୍ରବ୍ୟ ସାଙ୍ଗରେ ଆଣିବେ ନାହଁ|',
                                  style: TextStyle(
                                    fontSize: 10,
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'କ୍ୟାମ୍ପରେ ଟେପ ରେକର୍ଡର ବ୍ୟବହାର ନିଷିଦ୍ଧ|',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              'ହଜିଯାଇଥିଲେ ଯୋଗାଯୋଗ କରନ୍ତୁ 7738261091',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      children: [
                        Divider(
                          color: Colors.white,
                        ),
                        Center(
                            child: Text(
                          'ହଜିଯାଇଥିଲେ ଯୋଗାଯୋଗ କରନ୍ତୁ 7738261091',
                          style: TextStyle(color: Colors.white),
                        )),
                      ],
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
