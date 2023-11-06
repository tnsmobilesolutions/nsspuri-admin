// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/post_devotee.dart';
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/constant/sangha_list.dart';
import 'package:sdp/model/address_model.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/utilities/color_palette.dart';

class AddPageDilouge extends StatefulWidget {
  AddPageDilouge({super.key, required this.title, this.devotee});
  String title;
  DevoteeModel? devotee;

  @override
  State<AddPageDilouge> createState() => _AddPageDilougeState();
}

class _AddPageDilougeState extends State<AddPageDilouge> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final sanghaController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? bloodGroupController;

  List gender = ["Male", "Female"];
  int genderController = 0;
  String? profileURL;

  String? profileImage;
  XFile? previewImage;
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

  get districtList => null;

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      previewImage = pickedFile;
    });
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: const Icon(Icons.photo_album),
                  title: const Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  String? select;
  String formattedDate =
      DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future<String?> uploadImageToFirebaseStorage(XFile image, String name) async {
    // print('**************${getImageName(image)}**************');
    Reference storage =
        FirebaseStorage.instance.ref('${name}/${getImageName(image)}');
    await storage.putFile(File(image.path));
    return await storage.getDownloadURL();
  }

  // return image name
  String getImageName(XFile image) {
    return image.path.split("/").last;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.white,
      ),
      height: 435,
      width: 400,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
            onPressed: () {
              showPhotoOptions();
            },
            child: CircleAvatar(
              backgroundImage:
                  previewImage != null && previewImage!.path.isNotEmpty
                      ? Image.file(
                          File('${previewImage?.path}'),
                          fit: BoxFit.cover,
                        ).image
                      : Image.network(profileURL.toString()).image,
              radius: 60,
              child: const Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: CircleAvatarClor,
                  radius: 20.0,
                  child: Icon(
                    Icons.camera_alt,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: nameController,
            onSaved: (newValue) => nameController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Name",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller: mobileController,
            onSaved: (newValue) => mobileController,
            validator: (value) {
              RegExp regex = RegExp(r'^.{10}$');
              if (value!.isEmpty) {
                return ("Please enter Phone Number");
              }
              if (!regex.hasMatch(value) && value.length != 10) {
                return ("Enter 10 Digit Mobile Number");
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Mobile Number",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
                          groupValue: genderController,
                          title: const Text(
                            "Male",
                          ),
                          onChanged: (newValue) =>
                              setState(() => genderController = newValue ?? 0),
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
                          groupValue: genderController,

                          title: const Text(
                            "Female",
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              genderController = newValue ?? 0;
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
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: TextField(
              controller: dateinput, //editing controller of this TextField
              decoration: InputDecoration(
                labelText: "Date Of Birth",
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    initialEntryMode:
                        DatePickerEntryMode.calendarOnly, // Hide edit button
                    fieldHintText: 'dd-MM-yyyy',
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        1900), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime.now());

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    dateinput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownButtonFormField(
                  value: bloodGroupController,

                  elevation: 16,
                  decoration: InputDecoration(
                    labelText: "Blood Group",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
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
          const SizedBox(
            height: 20,
          ),
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
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            suggestionsCallback: (value) {
              return SanghaList.getSuggestions(value);
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
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: addressLine1Controller,
            onSaved: (newValue) => addressLine1Controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter address line 1';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Address line 1",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: addressLine2Controller,
            onSaved: (newValue) => addressLine2Controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter address line 2';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Address line 2",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: cityController,
            onSaved: (newValue) => cityController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter city name';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "City Name",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: stateController,
            onSaved: (newValue) => stateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter state name';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "State Name",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: countryController,
            onSaved: (newValue) => addressLine1Controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter country name';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Country Name",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: postalCodeController,
            onSaved: (newValue) => postalCodeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter postal code';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "PIN Code",
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
            child: ElevatedButton(
              onPressed: () async {
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
                  profileURL = previewImage != null
                      ? await uploadImageToFirebaseStorage(
                          previewImage as XFile, nameController.text)
                      : null;
                  DevoteeModel updateDevotee = DevoteeModel(
                      bloodGroup: bloodGroupController,
                      name: nameController.text,
                      gender: gender[genderController],
                      profilePhotoUrl: profileURL,
                      sangha: sanghaController.text,
                      dob: dateinput.text,
                      mobileNumber: mobileController.text,
                      updatedAt: DateTime.now().toString(),
                      address: AddressModel(
                          addressLine2: addressLine2Controller.text,
                          addressLine1: addressLine1Controller.text,
                          country: countryController.text,
                          postalCode: int.tryParse(postalCodeController.text),
                          city: cityController.text,
                          state: stateController.text));
                  Map<String, dynamic> response;
                  if (widget.title == "edit") {
                    response = await PutDevoteeAPI().updateDevotee(
                        updateDevotee, widget.devotee?.devoteeId ?? "");
                  } else {
                    response = await PostDevoteeAPI()
                        .addRelativeDevotee(updateDevotee);
                  }

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
                    Navigator.of(context)
                        .pop(); // Close the circular progress indicator
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ));
                  } else {
                    Navigator.of(context)
                        .pop(); // Close the circular progress indicator
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('devotee update issue')));
                  }
                } catch (e) {
                  Navigator.of(context)
                      .pop(); // Close the circular progress indicator
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                  print(e);
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return ButtonColor;
                    }
                    return ButtonColor;
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)))),
              child: const Text(
                'Next',
              ),

              //Row
            ),
          ),
        ]),
      ),
    );
  }
}
