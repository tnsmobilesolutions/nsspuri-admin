import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:flutter/material.dart';

class AnimatedShimmerWidget extends StatefulWidget {
  const AnimatedShimmerWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedShimmerWidget> createState() => _AnimatedShimmerWidgetState();
}

class _AnimatedShimmerWidgetState extends State<AnimatedShimmerWidget> {
  DataColumn dataColumn(BuildContext context, String header,
      [Function(int, bool)? onSort]) {
    return DataColumn(
        onSort: onSort,
        label: Flexible(
          flex: 1,
          child: Text(
            header,
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium?.merge(
                  const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
          ),
        ));
  }

  Widget createShimmer(int index) {
    return const AnimatedShimmer(
      height: 10,
      width: 80,
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: DataTable(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              columnSpacing: 10,
              dataRowMaxHeight: 80,
              columns: [
                dataColumn(context, 'Sl. No.'),
                dataColumn(context, 'Profile Image'),
                dataColumn(context, 'Devotee Name'),
                dataColumn(context, 'Sangha'),
                dataColumn(context, 'DOB/Age Group'),
                dataColumn(context, 'Status'),
                dataColumn(context, 'View'),
                dataColumn(context, 'Print'),
                dataColumn(context, 'Edit'),
              ],
              rows: List.generate(
                10,
                (index) {
                  return DataRow(
                    cells: [
                      const DataCell(
                        AnimatedShimmer(
                          height: 10,
                          width: 30,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      DataCell(
                        AnimatedShimmer.round(size: 70),
                      ),
                      const DataCell(
                        AnimatedShimmer(
                          height: 10,
                          width: 200,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      const DataCell(
                        AnimatedShimmer(
                          height: 10,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      const DataCell(
                        AnimatedShimmer(
                          height: 10,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      const DataCell(
                        AnimatedShimmer(
                          height: 10,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      DataCell(
                        AnimatedShimmer.round(size: 30),
                      ),
                      DataCell(
                        AnimatedShimmer.round(size: 30),
                      ),
                      DataCell(
                        AnimatedShimmer.round(size: 30),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
