// ignore_for_file: file_names, must_be_immutable
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/API/post_devotee.dart';
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/constant/sangha_list.dart';
import 'package:sdp/model/address_model.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/utilities/color_palette.dart';
import 'package:uuid/uuid.dart';

class AddPageDilouge extends StatefulWidget {
  AddPageDilouge({
    super.key,
    required this.title,
    required this.devoteeId,
  });

  String devoteeId;
  String title;

  @override
  State<AddPageDilouge> createState() => _AddPageDilougeState();
}

class _AddPageDilougeState extends State<AddPageDilouge> {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
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

  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  XFile? fileImage;
  final formKey = GlobalKey<FormState>();
  String formattedDate =
      DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());

  List gender = ["Male", "Female"];
  int genderController = 0;
  Map<String, dynamic>? image;
  String? imageName;
  String? imageUploadData;
  Uint8List? imageasbytes;
  File? imagefile;
  bool isAdmin = false;
  bool isApproved = false;
  bool isAvailable = false;
  bool isGruhasanaApproved = false;
  bool isKYDVerified = false;
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  XFile? pickImage;
  TextEditingController postalCodeController = TextEditingController();
  String? profileImage;
  String profilePhotoUrl = "";
  TextEditingController sanghaController = TextEditingController();
  String? select;
  DevoteeModel? selectedDevotee;
  List<int>? selectedImage;
  String selectedStatus = 'dataSubmitted'; // Initially selected status
  List<int>? selectedimage;
  TextEditingController stateController = TextEditingController();
  List<String> statusOptions = [
    'dataSubmitted',
    'paid',
    'rejected',
    'accepted',
    'printed',
    'withdrawn',
    'lost',
    'reissued',
    "blacklisted"
  ];

  @override
  void initState() {
    super.initState();
    populateData();
  }

  get districtList => null;

  // String getImageName(XFile image) {
  //   return image.path.split("/").last;
  // }

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

  populateData() async {
    if (widget.title == "edit") {
      final devoteeData =
          await GetDevoteeAPI().devoteeDetailsById(widget.devoteeId);
      setState(() {
        selectedDevotee = devoteeData?["data"];
        if (devoteeData?["statusCode"] == 200) {
          selectedStatus = selectedDevotee?.status ?? "dataSubmitted";
          nameController.text = selectedDevotee?.name ?? "";
          emailController.text = selectedDevotee?.emailId ?? "";
          mobileController.text = selectedDevotee?.mobileNumber ?? "";
          sanghaController.text = selectedDevotee?.sangha ?? "";
          dateOfBirth.text = selectedDevotee?.dob ?? "";
          addressLine1Controller.text =
              selectedDevotee?.address?.addressLine1 ?? "";
          addressLine2Controller.text =
              selectedDevotee?.address?.addressLine2 ?? "";
          cityController.text = selectedDevotee?.address?.city ?? "";
          stateController.text = selectedDevotee?.address?.state ?? "";
          countryController.text = selectedDevotee?.address?.country ?? "";
          postalCodeController.text =
              (selectedDevotee?.address?.postalCode != null ||
                      selectedDevotee?.address?.postalCode != 0)
                  ? selectedDevotee?.address?.postalCode.toString() ?? ""
                  : "";
          selectedDevotee?.address?.postalCode.toString() ?? "";
          profilePhotoUrl = selectedDevotee?.profilePhotoUrl ?? "";
          isAdmin = selectedDevotee?.isAdmin ?? false;
          isKYDVerified = selectedDevotee?.isKYDVerified ?? false;
          isApproved = selectedDevotee?.isApproved ?? false;
          isGruhasanaApproved = selectedDevotee?.isGruhasanaApproved ?? false;
          bloodGroupController = selectedDevotee?.bloodGroup ?? "Don't know";
          genderController = selectedDevotee?.gender == "Male" ? 0 : 1;
        }
      });
    }
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
          color: Colors.white,
        ),
        height: 435,
        width: 400,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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

            // UploadProfileImage(
            //   selectedImage: selectedImage,
            //   // data: widget.carousalData,
            //   onImageSelected: (image, xfileImage) {
            //     setState(() {
            //       selectedImage = image?['selectedImage'];
            //       imageName = image?['fileName'];
            //       fileImage = xfileImage;
            //     });
            //   },
            // ),
            const SizedBox(height: 10),
            widget.title == "edit"
                ? DropdownButton<String>(
                    value: selectedStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                    underline: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey), // Border color
                        borderRadius:
                            BorderRadius.circular(30.0), // Border radius
                      ),
                    ),
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black), // Dropdown text color
                    items: statusOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            widget.title == "edit"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('isAdmin'),
                        Checkbox(
                          checkColor: Colors.deepOrange,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isAdmin,
                          onChanged: (bool? value) {},
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            widget.title == "edit"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('isGruhasanaApproved'),
                        Checkbox(
                          checkColor: Colors.deepOrange,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isGruhasanaApproved,
                          onChanged: (bool? value) {
                            setState(() {
                              isGruhasanaApproved = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            widget.title == "edit"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('isKYDVerified'),
                        Checkbox(
                          checkColor: Colors.deepOrange,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isKYDVerified,
                          onChanged: (bool? value) {
                            setState(() {
                              isKYDVerified = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
            widget.title == "edit"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('isApproved'),
                        Checkbox(
                          checkColor: Colors.deepOrange,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isApproved,
                          onChanged: (bool? value) {
                            setState(() {
                              isApproved = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
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
              controller: emailController,
              onSaved: (newValue) => emailController,
              validator: (value) {
                if (value?.isEmpty == true || value == null) {
                  return null;
                }
                if (!emailRegex.hasMatch(value)) {
                  return "Invalid email !";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Email Id",
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
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
                              "Bhai",
                            ),
                            onChanged: (newValue) => setState(
                                () => genderController = newValue ?? 0),
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
                              "Maa",
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                genderController = newValue ?? 1;
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
                controller: dateOfBirth, //editing controller of this TextField
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
                      dateOfBirth.text =
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
            const SizedBox(
              height: 20,
            ),
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter address line 2';
              //   }
              //   return null;
              // },
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter city name';
              //   }
              //   return null;
              // },
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter state name';
              //   }
              //   return null;
              // },
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
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter country name';
              //   }
              //   return null;
              // },
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState != null &&
                      formKey.currentState!.validate()) {
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
                      String? profileURL = image?["selectedImage"] != null
                          ? await uploadImageToFirebaseStorage(
                              image?["selectedImage"] as List<int>,
                              nameController.text)
                          : selectedDevotee?.profilePhotoUrl;
                      print("profileURL -------------$profileURL");
                      String uniqueDevoteeId = const Uuid().v1();
                      DevoteeModel updateDevotee = DevoteeModel(
                          devoteeCode:
                              selectedDevotee?.devoteeCode?.toInt() ?? 0,
                          isAdmin: selectedDevotee?.isAdmin ?? false,
                          createdById: widget.title == "edit"
                              ? selectedDevotee?.createdById
                              : uniqueDevoteeId,
                          status: selectedStatus,
                          createdOn: selectedDevotee?.createdOn ??
                              DateFormat('yyyy-MM-dd HH:mm')
                                  .format(DateTime.now()),
                          isApproved: isApproved,
                          devoteeId: widget.title == "edit"
                              ? widget.devoteeId
                              : uniqueDevoteeId,
                          bloodGroup: bloodGroupController,
                          name: nameController.text,
                          gender: gender[genderController],
                          profilePhotoUrl: profileURL,
                          sangha: sanghaController.text,
                          dob: dateOfBirth.text,
                          mobileNumber: mobileController.text,
                          updatedOn: DateTime.now().toString(),
                          emailId: emailController.text,
                          isGruhasanaApproved: isGruhasanaApproved,
                          isKYDVerified: isKYDVerified,
                          uid: selectedDevotee?.uid ?? "",
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
                      if (widget.title == "edit") {
                        response = await PutDevoteeAPI()
                            .updateDevotee(updateDevotee, widget.devoteeId);
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
                            const SnackBar(
                                content: Text('devotee update issue')));
                      }
                    } catch (e) {
                      Navigator.of(context)
                          .pop(); // Close the circular progress indicator
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90)))),
                child: Text(
                  widget.title == "edit" ? "Update" : "Add",
                ),

                //Row
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
