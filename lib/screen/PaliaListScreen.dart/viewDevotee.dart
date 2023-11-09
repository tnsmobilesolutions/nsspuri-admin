// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';

class ViewPalia extends StatefulWidget {
  const ViewPalia({Key? key, required this.devoteeDetails}) : super(key: key);
  final DevoteeModel devoteeDetails;

  @override
  State<ViewPalia> createState() => _ViewPaliaState();
}

class _ViewPaliaState extends State<ViewPalia>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        0.0,
                      ),
                      color: Colors.blue),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: 'Devotee Info',
                    ),
                    Tab(
                      text: 'Sammilani Delegate Info',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Column(
                        children: [
                          // viewDetails('Sangha', widget.item.sangha.toString()),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'DOB',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(widget.devoteeDetails.toString())
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Pranaami',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('₹${widget.devoteeDetails.bloodGroup}')
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
                                  Text('${widget.devoteeDetails.bloodGroup}')
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Sammilani Year',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('${widget.devoteeDetails.bloodGroup},')
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Sammilani Place',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('${widget.devoteeDetails.bloodGroup}')
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
                                  Text('${widget.devoteeDetails.bloodGroup}')
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Receipt Date',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('${widget.devoteeDetails.bloodGroup}')
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
                              Text(widget.devoteeDetails.bloodGroup.toString())
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
                                  Text(widget.devoteeDetails.bloodGroup
                                      .toString())
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Created On',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(widget.devoteeDetails.createdAt
                                      .toString())
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 0.5,
                          ),
                          if (widget.devoteeDetails.createdAt != null)
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
                                    Text(widget.devoteeDetails.createdAt
                                        .toString())
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Updated On',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(widget.devoteeDetails.createdAt
                                        .toString())
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Page Two',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
  

              // Expanded(
              //   child: TabBarView(
              //     controller: _tabController,
              //     children: [
              //       Center(
              //         child: ListBody(
              //           children: [
              //             // viewDetails('Name', widget.item.name.toString()),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   'Name',
              //                   style: TextStyle(color: Colors.grey),
              //                 ),
              //                 Text(widget.devoteeDetails.name.toString())
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             // viewDetails('Sangha', widget.item.sangha.toString()),

              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   'Sangha',
              //                   style: TextStyle(color: Colors.grey),
              //                 ),
              //                 Text(widget.devoteeDetails.sangha.toString())
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     const Text(
              //                       'DOB',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text(widget.devoteeDetails.dob.toString())
              //                   ],
              //                 ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.end,
              //                   children: [
              //                     const Text(
              //                       'Pranaami',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text('₹${widget.devoteeDetails.bloodGroup}')
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     const Text(
              //                       'Sammilani No.',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text('${widget.devoteeDetails.bloodGroup}')
              //                   ],
              //                 ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.end,
              //                   children: [
              //                     const Text(
              //                       'Sammilani Year',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text('${widget.devoteeDetails.bloodGroup},')
              //                   ],
              //                 ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.end,
              //                   children: [
              //                     const Text(
              //                       'Sammilani Place',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text('${widget.devoteeDetails.bloodGroup}')
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     const Text(
              //                       'Receipt No.',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text('${widget.devoteeDetails.bloodGroup}')
              //                   ],
              //                 ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.end,
              //                   children: [
              //                     const Text(
              //                       'Receipt Date',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text('${widget.devoteeDetails.bloodGroup}')
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   'Remark',
              //                   style: TextStyle(color: Colors.grey),
              //                 ),
              //                 Text(widget.devoteeDetails.bloodGroup.toString())
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     const Text(
              //                       'Created By',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text(widget.devoteeDetails.bloodGroup
              //                         .toString())
              //                   ],
              //                 ),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.end,
              //                   children: [
              //                     const Text(
              //                       'Created On',
              //                       style: TextStyle(color: Colors.grey),
              //                     ),
              //                     Text(widget.devoteeDetails.createdAt
              //                         .toString())
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const Divider(
              //               thickness: 0.5,
              //             ),
              //             if (widget.devoteeDetails.createdAt != null)
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const Text(
              //                         'Updated By',
              //                         style: TextStyle(color: Colors.grey),
              //                       ),
              //                       Text(widget.devoteeDetails.createdAt
              //                           .toString())
              //                     ],
              //                   ),
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       const Text(
              //                         'Updated On',
              //                         style: TextStyle(color: Colors.grey),
              //                       ),
              //                       Text(widget.devoteeDetails.createdAt
              //                           .toString())
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //           ],
              //         ),
              //       ),
  



