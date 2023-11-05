// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';


class ViewPalia extends StatefulWidget {
  const ViewPalia({Key? key, required this.item}) : super(key: key);
  final DevoteeModel item;

  @override
  State<ViewPalia> createState() => _ViewPaliaState();
}

class _ViewPaliaState extends State<ViewPalia> {
  // viewDetails(String heading, String value) {
  //   Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         heading,
  //         style: TextStyle(color: Colors.grey),
  //       ),
  //       Text(value)
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      width: 500,
      child: SingleChildScrollView(
        child: ListBody(
          children: [
            // viewDetails('Name', widget.item.name.toString()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(widget.item.name.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            // viewDetails('Sangha', widget.item.sangha.toString()),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sangha',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(widget.item.sangha.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pali Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(widget.item.createdAt.toString())
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Pranaami',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('₹${widget.item.bloodGroup}')
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sammilani No.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('${widget.item.bloodGroup}')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Sammilani Year',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('${widget.item.bloodGroup},')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Sammilani Place',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('${widget.item.bloodGroup}')
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Receipt No.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('${widget.item.bloodGroup}')
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Receipt Date',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('${widget.item.bloodGroup}')
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remark',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(widget.item.bloodGroup.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Created By',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(widget.item.bloodGroup.toString())
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Created On',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(widget.item.createdAt.toString())
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            if (widget.item.createdAt != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Updated By',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.item.createdAt.toString())
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Updated On',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(widget.item.createdAt.toString())
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
