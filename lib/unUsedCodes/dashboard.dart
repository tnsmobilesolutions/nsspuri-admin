// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sdp/API/paliaaAPI.dart';
// import 'package:sdp/API/userAPI.dart';
// import 'package:sdp/Login/EmailSignIn.dart';
// import 'package:sdp/Models/sammilaniModel.dart';
// import 'package:sdp/Models/vaktaModel.dart';
// import 'package:sdp/unUsedCodes/add_edit_dilougeBox.dart';
// import 'package:sdp/screen/appBar/actionWidget.dart';
// import 'package:sdp/screen/appBar/leadingImage.dart';
// import 'package:sdp/unUsedCodes/homeScreen.dart';
// import 'package:sdp/unUsedCodes/newSearch.dart';
// import 'package:sdp/screen/appBar/search.dart';
// import 'package:uuid/uuid.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   final PaliaNameController = TextEditingController();
//   final paliDateController = TextEditingController();
//   final receiptDateController = TextEditingController();
//   final sanghaNameController = TextEditingController();
//   final sammilaniPlaceController = TextEditingController();
//   final pranamiController = TextEditingController();
//   final sammilaniYearController = TextEditingController();
//   final remarkController = TextEditingController();
//   final sammilaniNumberController = TextEditingController();
//   final receiptNumberController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   VaktaModel? editedVaktadata;
//   List<VaktaModel>? searchItem;
//   // List<VaktaModel> devotedetails = [];
//   int dashboardindexNumber = 0;
//   int searchDasboardIndexNumber = 0;
//   int printDashboardIndexNumber = 0;
//   int printSearchIndexNumber = 0;
//   bool showButtons = false;
//   String? selectedtypesearch;
//   String? sdpseacrchfield;
//   var baloobhaina2font;
//   var notoSansfont;
//   @override
//   Widget build(BuildContext context) {
//     showdilouge(
//       String title,
//       String buttonText,
//     ) {
//       showDialog(
//         context: context,
//         // barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Color(0XFF3f51b5),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.close))
//               ],
//             ),
//             content: SingleChildScrollView(
//                 child: Add_Edit_Dialougebox(
//               receiptDateController: receiptDateController,
//               receiptNumberController: receiptNumberController,
//               PaliaNameController: PaliaNameController,
//               formKey: _formKey,
//               paliDateController: paliDateController,
//               pranamiController: pranamiController,
//               remarkController: remarkController,
//               sammilaniNumberController: sammilaniNumberController,
//               sammilaniYearController: sammilaniYearController,
//               sanghaNameController: sanghaNameController,
//               sammilaniPlaceController: sammilaniPlaceController,
//             )),
//             actions: <Widget>[
//               Center(
//                 child: CupertinoButton(
//                   color: const Color(0XFF3f51b5),
//                   child: Text(buttonText),
//                   onPressed: () async {
//                     final currentUserData =
//                         await UserAPI().getCurrentUserData();

//                     DateTime now = DateTime.now();
//                     String formattedDate =
//                         DateFormat('dd-MMM-yyyy  hh:mm a').format(now);
//                     // DateFormat('yyyy-MM-dd – kk:mm').format(now);

//                     if (_formKey.currentState != null) {
//                       if (_formKey.currentState!.validate()) {
//                         if (buttonText == 'Add') {
//                           VaktaModel addUser = VaktaModel(
//                             sammilaniData: SammilaniModel(
//                                 sammilaniNumber:
//                                     sammilaniNumberController.text.trim(),
//                                 sammilaniYear:
//                                     sammilaniYearController.text.trim(),
//                                 sammilaniPlace:
//                                     sammilaniPlaceController.text.trim()),
//                             name: PaliaNameController.text.trim(),
//                             createdBy: currentUserData?.name,
//                             createdOn: formattedDate.toString(),
//                             // formatted.toString(),
//                             docId: const Uuid().v1(),
//                             pranaami: double.parse(
//                                 pranamiController.text.trim() == ''
//                                     ? '0.0'
//                                     : pranamiController.text.trim()),
//                             remark: remarkController.text.trim(),
//                             sangha: sanghaNameController.text.trim(),
//                             paaliDate: paliDateController.text,
//                             receiptDate: receiptDateController.text,
//                             receiptNo: receiptNumberController.text,
//                           );
//                           await PaliaAPI().addUser(addUser);
//                           Navigator.popUntil(context, (route) => route.isFirst);
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return const HomeScreen();
//                             },
//                           ));
//                         }
//                       }
//                     }
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         leading: const LeadingImage(),
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'ସମ୍ମିଳନୀ ଦିନିକିଆ ପାଳି',
//         ),
//         actions: const [ActionWidget()],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(50.0),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width / 4,
//                     child: Card(
//                       elevation: 20,
//                       shadowColor: const Color(0XFF3f51b5),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: const [
//                                 Text(
//                                   '71',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   'ସମ୍ମିଳନୀ',
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                                 Text(
//                                   '2022',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 //  Text(
//                                 //       '71 ସମ୍ମିଳନୀ\n2000 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
//                                 //       style: TextStyle(
//                                 //           fontSize: 20, fontWeight: FontWeight.bold),
//                                 // ),
//                               ],
//                             ),
//                             const Text(
//                               'Satsikhya Mandir, Bhubaneswar',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.normal),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: const [
//                                 Text(
//                                   '2000',
//                                   style: TextStyle(
//                                       fontSize: 50,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   'ଦିନିକିଆ ପାଳି',
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.normal),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width / 4,
//                     child: const Card(
//                       elevation: 20,
//                       shadowColor: Color(0XFF3f51b5),
//                       child: Padding(
//                         padding: EdgeInsets.all(25.0),
//                         child: Text(
//                           '70th ସମ୍ମିଳନୀ\n1500 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width / 4,
//                     child: const Card(
//                       elevation: 20,
//                       shadowColor: Color(0XFF3f51b5),
//                       child: Padding(
//                         padding: EdgeInsets.all(25.0),
//                         child: Text(
//                           '69th ସମ୍ମିଳନୀ\n1000 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width / 4,
//                     child: const Card(
//                       elevation: 20,
//                       shadowColor: Color(0XFF3f51b5),
//                       child: Padding(
//                         padding: EdgeInsets.all(25.0),
//                         child: Text(
//                           '68th ସମ୍ମିଳନୀ\n500 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width / 4,
//                     child: const Card(
//                       elevation: 20,
//                       shadowColor: Color(0XFF3f51b5),
//                       child: Padding(
//                         padding: EdgeInsets.all(25.0),
//                         child: Text(
//                           '67th ସମ୍ମିଳନୀ\n200 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     width: MediaQuery.of(context).size.width / 4,
//                     child: const Card(
//                       elevation: 20,
//                       shadowColor: Color(0XFF3f51b5),
//                       child: Padding(
//                         padding: EdgeInsets.all(25.0),
//                         child: Text(
//                           '66th ସମ୍ମିଳନୀ\n100 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
