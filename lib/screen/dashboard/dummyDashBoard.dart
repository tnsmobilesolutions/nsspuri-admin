// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DummyDashBoard extends StatelessWidget {
  const DummyDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10,
                shadowColor: const Color(0XFF3f51b5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     Text(''),
                      //     Text(
                      //       '',
                      //       style: TextStyle(
                      //           fontSize: 17, fontWeight: FontWeight.normal),
                      //     ),
                      //     Text(''),
                      //   ],
                      // ),
                      // const Text(''),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [Text(''), Text('')],
                      // )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
