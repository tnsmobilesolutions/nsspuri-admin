// ignore_for_file: file_names, must_be_immutable, avoid_print
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sdp/API/get_devotee.dart';

import 'package:sdp/API/post_devotee.dart';
import 'package:sdp/constant/sangha_list.dart';
import 'package:sdp/model/address_model.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/appBar/custom_calendar.dart';

import 'package:sdp/screen/user/userDashboard.dart';
import 'package:sdp/utilities/color_palette.dart';
import 'package:sdp/utilities/network_helper.dart';

import 'package:uuid/uuid.dart';

class UserSignUpDelegate extends StatefulWidget {
  UserSignUpDelegate({
    super.key,
    required this.title,
    required this.devoteeId,
    this.searchBy,
    this.searchValue,
    this.showClearButton,
  });

  String devoteeId;
  String? searchBy;
  String? searchValue;
  bool? showClearButton;
  String title;

  @override
  State<UserSignUpDelegate> createState() => _UserSignUpDelegateState();
}

class _UserSignUpDelegateState extends State<UserSignUpDelegate> {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  String? uid;
  String? bloodGroupController;
  List<String> bloodGrouplist = <String>[
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
    "Don't know",
  ];
  final passwordController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  bool _obscured1 = true;
  bool _obscured2 = true;
  int ageGroupIndex = 0;
  List<String> ageGroup = ["1 to 12", "13 to 70", "70 Above"];
  String selectedAgeGroup = "13 to 70";
  String getAgeGroup(DevoteeModel? devotee) {
    if (devotee?.ageGroup != null && devotee?.ageGroup?.isNotEmpty == true) {
      return devotee?.ageGroup.toString() ?? "";
    }
    return "";
  }

  int getAgeGroupIndex(DevoteeModel? devotee) {
    if (devotee?.dob?.isEmpty == true || devotee?.dob == null) {
      if (devotee?.ageGroup?.isNotEmpty == true || devotee?.ageGroup != null) {
        return 1;
      }
    }
    return 0;
  }

  void _toggleObscured1() {
    setState(() {
      _obscured1 = !_obscured1;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  FocusNode focusNode = FocusNode();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final decimalRegex = [
    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*$')),
    TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.contains('..')) {
        final newString = newValue.text.replaceAll('..', '.');
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(offset: newString.length),
        );
      }
      return newValue;
    }),
  ];

  TextEditingController emailController = TextEditingController();
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  XFile? fileImage;
  final formKey = GlobalKey<FormState>();
  String formattedDate =
      DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());

  List gender = ["Male", "Female"];
  int genderIndex = 0;
  int ageIndex = 0;
  Map<String, dynamic>? image;
  String? imageName;
  String? imageUploadData;
  Uint8List? imageasbytes;
  File? imagefile;
  bool isAdmin = false;
  bool isApproved = false;
  bool isAvailable = false;
  bool isGruhasanaApproved = false;
  bool isGuest = false;
  bool isKYDVerified = false;
  bool isOrganizer = false;
  bool isSpeciallyAbled = false;
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final numericRegex = [
    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
    TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) {
        return newValue;
      }
      final intValue = int.tryParse(newValue.text);
      if (intValue == null) {
        return oldValue;
      }
      return newValue;
    }),
  ];

  bool? parichayaPatraValue = false, shouldShowPranamiField = false;
  XFile? pickImage;
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController pranamiController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String? profileImage;
  String profilePhotoUrl = "";

  String day = "", month = "", year = "";
  TextEditingController sanghaController = TextEditingController();
  String? select;
  DevoteeModel? selectedDevotee;
  List<int>? selectedImage;
  String selectedRole = 'User';
  String selectedStatus = 'dataSubmitted';
  List<int>? selectedimage;
  TextEditingController stateController = TextEditingController();

  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  FocusNode dobFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();

  @override
  void dispose() {
    dobFocusNode.dispose();
    ageFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  get districtList => null;

  Future<String?> uploadImageToFirebaseStorage(
      List<int> imageData, String? name) async {
    try {
      Uint8List bytes = Uint8List.fromList(imageData);
      Reference storage = FirebaseStorage.instance
          .ref('$name/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storage.putData(bytes);

      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _showCustomCalendarDialog(BuildContext context) async {
    final selectedDate = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Date",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              content: CustomCalender(
                day: day,
                month: month,
                year: year,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        );
      },
    );

    if (selectedDate != null) {
      print("selected date: $selectedDate");
      dobController.text = selectedDate;
      List<String> selectedDateParts = selectedDate.split('-');
     
      setState(() {
        day = selectedDateParts[0];
        month = selectedDateParts[1];
        year = selectedDateParts[2];
      });
    }
  }

  String _formatDOB(String dob) {
    if (dob.isEmpty) {
      return "";
    }
    try {
      DateTime dateTime = DateFormat('d-MMM-yyyy', 'en_US').parse(dob);
      String formattedDate = DateFormat('y-MM-dd').format(dateTime);
      return formattedDate;
    } catch (e) {
      print("Error parsing date: $e");
      return '';
    }
  }

  String formatDate(String inputDate) {
    if (inputDate != "") {
      DateTime dateTime = DateFormat('yyyy-MM-dd', 'en_US').parse(inputDate);

      int day = dateTime.day;
      String month = monthNames[dateTime.month - 1];
      int year = dateTime.year;

      String formattedDate = '$day-$month-$year';

      return formattedDate;
    }
    return "";
  }

  InputDecoration textFormFieldDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 238, 240, 250),
      errorMaxLines: 2,
      errorStyle: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(
            color: Colors.deepOrange,
          )),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange)),
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      hintText: "₹ 100",
      hintStyle: const TextStyle(fontSize: 13),
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            // Update state from outside the build method
            handleRadioButtonChange(value);
          },
        ),
        Text(title)
      ],
    );
  }

  void handleRadioButtonChange(dynamic value) {
    setState(() {
      select = value;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final List<int> bytes = await pickedFile.readAsBytes();
      setState(() {
        image = {'selectedImage': bytes};
        pickImage = pickedFile;
      });
      // widget.onImageSelected(image, pickImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        // MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          //color: Colors.white,
        ),
        height: 435,
        width: 400,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: image?["selectedImage"] != null
                      ? Image.memory(image?['selectedImage']).image
                      : (profilePhotoUrl.isNotEmpty)
                          ? Image.network(profilePhotoUrl.toString()).image
                          : const AssetImage(
                              'assets/images/profile.jpeg'), // Set your default image asset path here
                  radius: 40,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Has Parichaya Patra?',
                      ),
                      Checkbox(
                        checkColor: Colors.deepOrange,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: parichayaPatraValue,
                        onChanged: (bool? value) {
                          setState(() {
                            parichayaPatraValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Specially Abled'),
                      Checkbox(
                        checkColor: Colors.deepOrange,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isSpeciallyAbled,
                        onChanged: (bool? value) {
                          setState(() {
                            isSpeciallyAbled = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  onSaved: (newValue) => nameController,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
                  // ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  onSaved: (newValue) => emailController,
                  validator: (value) {
                    if (value?.isEmpty == true || value == null) {
                      return "Please Enter Your Email";
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return "Invalid email !";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email Id",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,

                  // style: Theme.of(context).textTheme.displaySmall,
                  controller: passwordController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'\s')), // Deny whitespace
                  ],
                  onSaved: (newValue) => passwordController,
                  validator: (value) {
                    if (value?.isEmpty == true || value == null) {
                      return 'Please enter Password';
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long !";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscured1,
                  focusNode: textFieldFocusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    labelText: "Password",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                    hintText: "Password",
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: GestureDetector(
                        onTap: _toggleObscured1,
                        child: Icon(
                          _obscured1
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          size: 20,
                          color: IconButtonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   controller: mobileController,
                //   onSaved: (newValue) => mobileController,
                //   validator: (value) {
                //     RegExp regex = RegExp(r'^.{10}$');
                //     if (value!.isEmpty) {
                //       return null;
                //     }
                //     if (!regex.hasMatch(value) && value.length != 10) {
                //       return ("Enter 10 Digit Mobile Number");
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     labelText: "Mobile Number",
                //     labelStyle:
                //         TextStyle(color: Colors.grey[600], fontSize: 15),
                //     filled: true,
                //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(
                //             width: 0, style: BorderStyle.solid)),
                //   ),
                // ),
                const SizedBox(height: 20),
                IntlPhoneField(
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.deepOrange,
                  ),
                  focusNode: focusNode,
                  controller: mobileController,
                  invalidNumberMessage: "Please enter a valid phone number !",
                  keyboardType: TextInputType.phone,
                  pickerDialogStyle: PickerDialogStyle(
                    searchFieldCursorColor: Colors.deepOrange,
                    searchFieldInputDecoration: InputDecoration(
                      label: const Text('Search Country'),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  // validator: (phone) {
                  //   if (phone?.number.isEmpty == true) {
                  //     return "Mobile number is required !";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (phone) {
                    RegExp regex = RegExp(r'^.{10}$');
                    if (phone?.number.isEmpty == true) {
                      return null;
                    }
                    if (!regex.hasMatch(phone!.number) &&
                        phone.number.length != 10) {
                      return ("Enter 10 Digit Mobile Number");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                  initialCountryCode: 'IN',
                  onSaved: (value) {
                    mobileController.text = value.toString();
                  },
                  onChanged: (phone) {
                   
                  },
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Gender',
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 0,
                                groupValue: genderIndex,
                                title: const Text(
                                  "Bhai",
                                ),
                                onChanged: (newValue) =>
                                    setState(() => genderIndex = newValue ?? 0),
                                activeColor: RadioButtonColor,
                                // Set the unselected color to blue
                                selectedTileColor:
                                    RadioButtonColor, // Set the selected color
                                selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 1,
                                groupValue: genderIndex,

                                title: const Text(
                                  "Maa",
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    genderIndex = newValue ?? 1;
                                  });
                                },
                                activeColor: RadioButtonColor,
                                // Set the unselected color to blue
                                selectedTileColor:
                                    RadioButtonColor, // Set the selected color
                                selected: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Age Info',
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 0,
                                groupValue: ageGroupIndex,
                                title: const Text(
                                  "DOB",
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    ageGroupIndex = newValue ?? 0;
                                    if (ageGroupIndex == 0) {
                                      selectedAgeGroup = "";
                                    }
                                  });
                                },
                                activeColor: RadioButtonColor,
                                selected: false,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: RadioListTile(
                                value: 1,
                                groupValue: ageGroupIndex,
                                title: const Text(
                                  "Age Group",
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    ageGroupIndex = newValue ?? 1;
                                    if (ageGroupIndex == 1) {
                                      dobController.clear();
                                    }
                                  });
                                },
                                activeColor: RadioButtonColor,
                                selected: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ageGroupIndex == 0
                    ? GestureDetector(
                        child: TextField(
                          controller: dobController,
                          //focusNode: dobFocusNode,
                          decoration: InputDecoration(
                            labelText: "Date Of Birth",
                            labelStyle: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.deepOrange,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.solid)),
                          ),

                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () => _showCustomCalendarDialog(context),
                        ),
                      )
                    : DropdownButtonFormField<String>(
                        value: selectedAgeGroup,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAgeGroup = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select age group",
                          labelStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.solid)),
                        ),
                        items: ageGroup
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: bloodGroupController,

                        elevation: 16,
                        decoration: InputDecoration(
                          labelText: "Blood Group",
                          labelStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.solid)),
                        ),
                        // style: const TextStyle(color: Colors.deepPurple),

                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            bloodGroupController = value!;
                          });
                        },
                        items: bloodGrouplist
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TypeAheadFormField(
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 70,
                    child: Center(
                      child: Text('No Item Found'),
                    ),
                  ),
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                      color: SuggestionBoxColor,
                      elevation: 5,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  debounceDuration: const Duration(milliseconds: 400),
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: sanghaController,
                    decoration: InputDecoration(
                      labelText: "Sangha Name",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid)),
                    ),
                  ),
                  suggestionsCallback: (value) async {
                    final sanghas = await SanghaList().getSuggestions(value);
                    return sanghas;
                  },
                  itemBuilder: (context, String suggestion) {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 10,
                          height: 50,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              suggestion,
                              maxLines: 6,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    setState(() {
                      sanghaController.text = suggestion;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressLine1Controller,
                  onSaved: (newValue) => addressLine1Controller,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter address line 1';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    labelText: "Address line 1",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addressLine2Controller,
                  onSaved: (newValue) => addressLine2Controller,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter address line 2';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    labelText: "Address line 2",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cityController,
                  onSaved: (newValue) => cityController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter city name';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    labelText: "City Name",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: stateController,
                  onSaved: (newValue) => stateController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter state name';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    labelText: "State Name",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: countryController,
                  onSaved: (newValue) => addressLine1Controller,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter country name';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    labelText: "Country Name",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: postalCodeController,
                  onSaved: (newValue) => postalCodeController,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter postal code';
                  //   } else if (value.length > 7) {
                  //     return 'Please enter valid postal code';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    labelText: "PIN Code",
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 15),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.solid)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    // readOnly: true,
                    //keyboardType: TextInputType.number,
                    controller: remarksController,
                    onSaved: ((newValue) {
                      setState(() {
                        remarksController.text = newValue ?? "";
                      });
                    }),
                    decoration: InputDecoration(
                      labelText: "Remarks",
                      labelStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      filled: true,
                      floatingLabelBehavior: remarksController.text.isNotEmpty
                          ? FloatingLabelBehavior.auto
                          : FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid)),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        String setAgeGroupToDB() {
                          if (ageGroupIndex == 0) {
                            return "";
                          } else {
                            if (selectedAgeGroup == "1 to 12") {
                              return "Child";
                            } else if (selectedAgeGroup == "13 to 70") {
                              return "Adult";
                            } else if (selectedAgeGroup == "70 Above") {
                              return "Elder";
                            }
                            return "Adult";
                          }
                        }

                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent dismissing by tapping outside
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        await Future.delayed(
                            const Duration(seconds: 1)); // Simulating a delay
                        try {
//firebase signup
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              )
                              .then((value) => uid = value.user?.uid);

                          String? profileURL = image?["selectedImage"] != null
                              ? await uploadImageToFirebaseStorage(
                                  image?["selectedImage"] as List<int>,
                                  nameController.text)
                              : selectedDevotee?.profilePhotoUrl;

                          String uniqueDevoteeId = const Uuid().v1();
                          DevoteeModel updateDevotee = DevoteeModel(
                              devoteeId: uniqueDevoteeId,
                              createdById: uniqueDevoteeId,
                              bloodGroup: bloodGroupController,
                              name: nameController.text,
                              remarks: remarksController.text,
                              gender: gender[genderIndex],
                              profilePhotoUrl: profileURL,
                              hasParichayaPatra: parichayaPatraValue,
                              sangha: sanghaController.text,
                              dob: _formatDOB(dobController.text),
                              ageGroup: setAgeGroupToDB(),
                              status: "dataSubmitted",
                              mobileNumber: mobileController.text,
                              updatedOn: DateTime.now().toString(),
                              emailId: emailController.text,
                              isSpeciallyAbled: isSpeciallyAbled,
                              uid: uid,
                              role: "User",
                              address: AddressModel(
                                  addressLine2: addressLine2Controller.text,
                                  addressLine1: addressLine1Controller.text,
                                  country: countryController.text,
                                  postalCode: (postalCodeController.text != "")
                                      ? int.tryParse(postalCodeController.text)
                                      : 0,
                                  city: cityController.text,
                                  state: stateController.text));
                          Map<String, dynamic> response;
                          if (uid != null || uid != "") {
                            response = await PostDevoteeAPI()
                                .signupDevotee(updateDevotee);
                           

                            if (response["statusCode"] == 200) {
                              // Show a circular progress indicator while navigating
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // Prevent dismissing by tapping outside
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                              final currentDevoteeResponse =
                                  await GetDevoteeAPI()
                                      .loginDevotee(uid.toString());
                              await fetchCurrentuser();
                             
                              DevoteeModel currentDevotee =
                                  currentDevoteeResponse?["data"];

                              if (context.mounted) {
                                Navigator.of(context)
                                    .pop(); // Close the circular progress indicator
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserDashboard(
                                          devoteeId: currentDevotee.devoteeId
                                              .toString()),
                                    ));
                              }
                            } else {
                              // if (context.mounted) {
                              //   Navigator.of(context).pop();
                              // }
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('devotee Create issue')));
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
// Close the circular progress indicator
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                          print(e);
                        }
                      } else {
                        return;
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return ButtonColor;
                          }
                          return ButtonColor;
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90)))),
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),

                    //Row
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReceivePaymentSubmitButton extends StatelessWidget {
  ReceivePaymentSubmitButton({
    super.key,
    required this.onPressed,
  });

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: const Size(100, 40),
        //side: const BorderSide(color: Colors.actionColor, width: 5),
      ),
      onPressed: onPressed,
      child: Text(
        "Submit",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.merge(const TextStyle(color: Colors.white)),
      ),
    );
  }
}
