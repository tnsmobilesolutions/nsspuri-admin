// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Add_Edit_Dialougebox extends StatefulWidget {
//   Add_Edit_Dialougebox({
//     Key? key,
//     this.PaliaNameController,
//     this.formKey,
//     this.paliDateController,
//     this.pranamiController,
//     this.remarkController,
//     this.sammilaniNumberController,
//     this.sammilaniYearController,
//     this.sanghaNameController,
//     this.receiptDateController,
//     this.receiptNumberController,
//     this.sammilaniPlaceController,
//   }) : super(key: key);
//   GlobalKey<FormState>? formKey;
//   TextEditingController? PaliaNameController;
//   TextEditingController? paliDateController;
//   TextEditingController? receiptDateController;
//   TextEditingController? sanghaNameController;
//   TextEditingController? sammilaniPlaceController;
//   TextEditingController? pranamiController;
//   TextEditingController? sammilaniYearController;
//   TextEditingController? remarkController;
//   TextEditingController? sammilaniNumberController;
//   TextEditingController? receiptNumberController;

//   @override
//   State<Add_Edit_Dialougebox> createState() => _Add_Edit_DialougeboxState();
// }

// class _Add_Edit_DialougeboxState extends State<Add_Edit_Dialougebox> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(2.0),
//         color: Colors.white,
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Colors.grey,
//         //     offset: Offset(0.0, 1.0), //(x,y)
//         //     blurRadius: 1.0,
//         //   ),
//         // ],
//       ),
//       height: 435,
//       width: 400,
//       child: Form(
//         key: widget.formKey,
//         child: SingleChildScrollView(
//           child: Scrollbar(
//             thickness: 2,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 //Palia Name
//                 TextFormField(
//                   controller: widget.PaliaNameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Name',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please Enter Name';
//                     }
//                     //  else if (!RegExp(r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
//                     //     .hasMatch(value)) {
//                     //   return 'Please Enter Name';
//                     // }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 5),
//                 //Sangha Name
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.sanghaNameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Sangha Name',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please Enter Sangha Name';
//                     }
//                     // else if (!RegExp(r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
//                     //     .hasMatch(value)) {
//                     //   return 'Please Enter Sangha Name';
//                     // }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 5),
//                 // Pranami
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.pranamiController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Pranami',
//                   ),
//                   // validator: (value) {
//                   //   if (value!.isEmpty) {
//                   //     return 'Please Enter Tab/Strip';
//                   //   } else if (!RegExp(r'^[0-9.]*$').hasMatch(value)) {
//                   //     return 'Please Enter Correct Tab/Strip';
//                   //   }
//                   //   return null;
//                   // },
//                 ),
//                 // Pali Date
//                 const SizedBox(height: 5),
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.paliDateController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                         onPressed: () async {
//                           DateTime? selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2022),
//                               lastDate: DateTime(2050));
//                           if (selectedDate != null) {
//                             setState(() {
//                               widget.paliDateController?.text =
//                                   DateFormat('dd-MMM-yyyy')
//                                       .format(selectedDate);
//                             });
//                           } else {
//                             widget.paliDateController?.text = '';
//                           }
//                         },
//                         icon: const Icon(Icons.calendar_month_rounded)),
//                     border: const OutlineInputBorder(),
//                     labelText: 'Pali Date (DD-MMM-YYYY)',
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 // C
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.receiptDateController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                         onPressed: () async {
//                           DateTime? selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2022),
//                               lastDate: DateTime(2050));
//                           if (selectedDate != null) {
//                             setState(() {
//                               widget.receiptDateController?.text =
//                                   DateFormat('dd-MMM-yyyy')
//                                       .format(selectedDate);
//                             });
//                           } else {
//                             widget.receiptDateController?.text = '';
//                           }
//                         },
//                         icon: const Icon(Icons.calendar_month_rounded)),
//                     border: const OutlineInputBorder(),
//                     labelText: 'Receipt Date (DD-MMM-YYYY)',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 // receipt Number
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.receiptNumberController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Receipt Number',
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 // Sammilani Number
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.sammilaniNumberController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Sammilani Number',
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 // Sammilani Year
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.sammilaniYearController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'sammilani Year',
//                   ),
//                 ),

//                 const SizedBox(height: 5),
//                 // Sammilani Place
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.sammilaniPlaceController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'sammilani Place',
//                   ),
//                 ),

//                 const SizedBox(height: 5),
//                 // Remark
//                 TextFormField(
//                   focusNode: FocusNode(
//                     descendantsAreFocusable: false,
//                   ),
//                   controller: widget.remarkController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Remark',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
