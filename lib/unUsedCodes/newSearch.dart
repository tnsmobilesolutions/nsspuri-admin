// ignore_for_file: file_names
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:sdp/screen/appBar/search.dart';

// class NewSearch extends StatefulWidget {
//   const NewSearch({super.key});

//   @override
//   State<NewSearch> createState() => _NewSearchState();
// }

// class _NewSearchState extends State<NewSearch> {
//   TextEditingController searchSanghaController = TextEditingController();
//   String? selectedtypesearch;
//   String? sdpseacrchfield;
//   dynamic? searchItem;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(children: [
//         SearchSDP(
//             onSubmitPress: (result, selectedSearchType, sdpSearchController) {
//           log(selectedSearchType);
//           log(sdpSearchController);
//           setState(() {
//             selectedtypesearch = selectedSearchType;
//             sdpseacrchfield = sdpSearchController;
//             searchItem = result;
//             print(result);
//           });
//         }),
//         if (selectedtypesearch == 'Sammilani Number')
//           SizedBox(
//             width: MediaQuery.of(context).size.width / 5,
//             child: Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: searchSanghaController,
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                       labelText: 'Please enter Sangha Name'),
//                   onChanged: (value) {
//                     searchSanghaController.text = value;
//                   },
//                 ),
//               ),
//             ),
//           ),
//       ]),
//     );
//   }
// }
