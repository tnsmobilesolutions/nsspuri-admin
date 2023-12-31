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
            return const Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                elevation: 10,
                shadowColor: Color.fromARGB(255, 0, 0, 0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
