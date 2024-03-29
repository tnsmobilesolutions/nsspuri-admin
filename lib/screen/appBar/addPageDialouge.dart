// ignore_for_file: file_names, must_be_immutable, avoid_print
import 'dart:io';
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
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/constant/pagination_value.dart';
import 'package:sdp/constant/sangha_list.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/address_model.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/appBar/custom_calendar.dart';
import 'package:sdp/screen/user/userDashboard.dart';
import 'package:sdp/utilities/color_palette.dart';
import 'package:sdp/utilities/network_helper.dart';
import 'package:uuid/uuid.dart';

class AddPageDilouge extends StatefulWidget {
  AddPageDilouge({
    super.key,
    required this.title,
    required this.devoteeId,
    this.searchBy,
    this.searchValue,
    this.showClearButton,
    this.role,
    this.advanceStatus,
    this.pageFrom,
    this.status,
    this.onUpdateDevotee,
  });

  void Function(
      List<DevoteeModel> allDevotees,
      String? status,
      String? pageFrom,
      String? searchBy,
      String? searchValue,
      bool? showClearButton)? onUpdateDevotee;

  String devoteeId;
  String? advanceStatus;
  String? role;
  String? pageFrom;
  String? status;
  String? searchBy;
  String? searchValue;
  bool? showClearButton;
  String title;

  @override
  State<AddPageDilouge> createState() => _AddPageDilougeState();
}

class _AddPageDilougeState extends State<AddPageDilouge> {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  FocusNode ageFocusNode = FocusNode();
  List<String> ageGroup = ["1 to 12", "13 to 70", "70 Above"];
  int ageGroupIndex = 0;
  List<String> approverstatusOptions = [
    'dataSubmitted',
    'approved',
    "rejected"
  ];

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
  TextEditingController receivedByController = TextEditingController();
  String day = "", month = "", year = "";
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

  TextEditingController dobController = TextEditingController();
  FocusNode dobFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  XFile? fileImage;
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String formattedDate =
      DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());

  List gender = ["Male", "Female"];
  List paymentMode = ["Cash", "Online"];
  int genderIndex = 0;
  int paymentModeIndex = 0;
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

  bool? parichayaPatraValue = false,
      shouldShowPranamiField = false,
      shouldShowdeliveredField = false;
  XFile? pickImage;
  TextEditingController postalCodeController = TextEditingController();
  // TextEditingController ageController = TextEditingController();
  TextEditingController pranamiController = TextEditingController();

  String? profileImage;
  String profilePhotoUrl = "";
  TextEditingController remarksController = TextEditingController();
  List<String> roleList = [
    'User',
    'Admin',
    'SuperAdmin',
    "Coordinator",
    'Approver',
    'PrasadScanner',
    "SecurityCheck",
    "SecurityAndPrasadScan",
    "Viewer",
  ];

  TextEditingController sanghaController = TextEditingController();
  String? select;
  String selectedAgeGroup = "13 to 70";
  DevoteeModel? selectedDevotee;
  List<int>? selectedImage;
  String selectedRole = 'User';
  String selectedStatus = 'dataSubmitted';
  List<int>? selectedimage;
  TextEditingController stateController = TextEditingController();
  List<String> statusOptions = [
    'dataSubmitted',
    'paid',
    'rejected',
    'approved',
    'printed',
    'withdrawn',
    'lost',
    'reissued',
    "blacklisted",
    "delivered"
  ];
  int totalPages = 0, dataCount = 0, currentPage = 1;

  @override
  void dispose() {
    dobFocusNode.dispose();
    ageFocusNode.dispose();
    super.dispose();
  }

  late int dataCountPerPage;
  @override
  void initState() {
    super.initState();
    dataCountPerPage = RemoteConfigHelper().getDataCountPerPage;
    // print("widget.devoteeId-----${widget.devoteeId}");
    if (widget.title == "edit") populateData();
    //print("page from: ${widget.pageFrom}");
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

  String getAgeGroup(DevoteeModel? devotee) {
    if (devotee?.ageGroup?.isNotEmpty == true || devotee?.ageGroup != null) {
      if (devotee?.ageGroup == "Child") {
        return "1 to 12";
      } else if (devotee?.ageGroup == "Adult") {
        return "13 to 70";
      } else if (devotee?.ageGroup == "Elder") {
        return "70 Above";
      }
      // return devotee?.ageGroup.toString() ?? "13 to 70";
    }
    return "13 to 70";
  }

  int getAgeGroupIndex(DevoteeModel? devotee) {
    if (devotee?.dob?.isEmpty == true || devotee?.dob == null) {
      if (devotee?.ageGroup?.isNotEmpty == true) {
        return 1;
      } else {
        return 0;
      }
    }
    return 0;
  }

  populateData() async {
    final devoteeData =
        await GetDevoteeAPI().devoteeDetailsById(widget.devoteeId);
    setState(() {
      selectedDevotee = devoteeData?["data"];
      if (selectedDevotee?.paidAmount != null) {
        shouldShowPranamiField = true;
        pranamiController.text = selectedDevotee?.paidAmount.toString() ?? "0";
      }
      if (selectedDevotee?.status == "delivered" ||
          selectedDevotee?.receivedBy != null || selectedDevotee?.receivedBy != "") {
        shouldShowdeliveredField = true;
        receivedByController.text = selectedDevotee?.receivedBy ?? "";
      }
      // else {
      //   shouldShowPranamiField = false;
      //   shouldShowdeliveredField = false;
      //   pranamiController.text = "0";
      // }
      if (devoteeData?["statusCode"] == 200) {
        if (selectedDevotee?.dob != null || selectedDevotee?.dob != "") {
          List<String> dateParts = selectedDevotee?.dob?.split('-') ?? [];

          if (dateParts.length >= 3) {
            setState(() {
              day = int.tryParse(dateParts[2])?.toString() ?? '';
              month = int.tryParse(dateParts[1])?.toString() ?? '';
              year = int.tryParse(dateParts[0])?.toString() ?? '';
            });
          } else {
            print('Invalid date format: ${selectedDevotee?.dob}');
          }
        }
        selectedStatus = selectedDevotee?.status ?? "dataSubmitted";
        selectedRole = selectedDevotee?.role ?? "User";
        nameController.text = selectedDevotee?.name ?? "";
        emailController.text = selectedDevotee?.emailId ?? "";
        mobileController.text = selectedDevotee?.mobileNumber ?? "";
        sanghaController.text = selectedDevotee?.sangha ?? "";
        parichayaPatraValue = selectedDevotee?.hasParichayaPatra ?? false;
        dobController.text =
            selectedDevotee?.dob != null || selectedDevotee?.dob != ""
                ? formatDate(selectedDevotee?.dob ?? "")
                : "";
        // shouldShowPranamiField = selectedDevotee?.status == "paid";
        // pranamiController.text = (selectedDevotee?.paidAmount != null
        //     ? selectedDevotee?.paidAmount.toString()
        //     : "")!;
        remarksController.text = selectedDevotee?.remarks ?? "";
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
        isSpeciallyAbled = selectedDevotee?.isSpeciallyAbled ?? false;
        isGuest = selectedDevotee?.isGuest ?? false;
        isOrganizer = selectedDevotee?.isOrganizer ?? false;
        isApproved = selectedDevotee?.isApproved ?? false;
        isGruhasanaApproved = selectedDevotee?.isGruhasanaApproved ?? false;
        bloodGroupController = selectedDevotee?.bloodGroup ?? "Don't know";
        genderIndex = selectedDevotee?.gender == "Male" ? 0 : 1;
        paymentModeIndex = selectedDevotee?.paymentMode == "Online" ? 1 : 0;
        //ageController.text = selectedDevotee?.ageGroup?.toString() ?? "";
        ageGroupIndex = getAgeGroupIndex(selectedDevotee);
        if (selectedDevotee?.ageGroup?.isNotEmpty == true) {
          selectedAgeGroup = getAgeGroup(selectedDevotee);
        }
      }
    });
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

  Future<String?> uploadProfileImage() async {
    return (image?["selectedImage"] != null)
        ? await uploadImageToFirebaseStorage(
            image?["selectedImage"] as List<int>, nameController.text)
        : selectedDevotee?.profilePhotoUrl;
  }

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

  DevoteeModel buildDevoteeModel(String? profileURL) {
    String uniqueDevoteeId = const Uuid().v1();
    return DevoteeModel(
        receivedBy: receivedByController.text,
        devoteeCode: selectedDevotee?.devoteeCode?.toInt() ?? 0,
        createdById: widget.title == "edit"
            ? selectedDevotee?.createdById
            : uniqueDevoteeId,
        status: selectedStatus,
        role: selectedRole,
        createdOn: selectedDevotee?.createdOn ??
            DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        isApproved: isApproved,
        devoteeId: widget.title == "edit" ? widget.devoteeId : uniqueDevoteeId,
        bloodGroup: bloodGroupController,
        name: nameController.text,
        remarks: remarksController.text,
        paidAmount: double.tryParse(pranamiController.text),
        gender: gender[genderIndex],
        paymentMode: paymentMode[paymentModeIndex],
        profilePhotoUrl: profileURL,
        hasParichayaPatra: parichayaPatraValue,
        sangha: sanghaController.text,
        dob: _formatDOB(dobController.text),
        ageGroup: setAgeGroupToDB(),
        mobileNumber: mobileController.text,
        updatedOn: DateTime.now().toString(),
        emailId: emailController.text,
        // isGruhasanaApproved: isGruhasanaApproved,
        // isKYDVerified: isKYDVerified,
        isSpeciallyAbled: isSpeciallyAbled,
        isGuest: isGuest,
        isOrganizer: isOrganizer,
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
  }

  Future<Map<String, dynamic>> submitDevoteeData(
      DevoteeModel updateDevotee) async {
    try {
      if (widget.title == "edit") {
        return await PutDevoteeAPI()
            .updateDevotee(updateDevotee, widget.devoteeId);
      } else {
        return await PostDevoteeAPI().addRelativeDevotee(updateDevotee);
      }
    } on Exception catch (e) {
      return {};
    }
  }

  void handleDevoteeSubmissionResponse(Map<String, dynamic> response) {
    if (response["statusCode"] == 200) {
      showCircularProgressIndicator();
      navigateToDashboard();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Devotee update issue')),
      );
      Navigator.of(context).pop();
    }
  }

  void handleException(dynamic e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
    print(e);
    Navigator.of(context).pop();
  }

  void showCircularProgressIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void navigateToDashboard() {
    if (widget.role == "User") {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDashboard(
            devoteeId: NetworkHelper().getCurrentDevotee?.devoteeId ?? "",
          ),
        ),
      );
    } else {
      handleDashboardNavigation();
    }
  }

  void handleDashboardNavigation() {
    if (widget.title == "edit") {
      updateDevoteeListOnEdit();
    } else {
      navigateToDevoteeListPage();
    }
  }

  void updateDevoteeListOnEdit() async {
    try {
      Map<String, dynamic>? allDevotee;
      List<DevoteeModel> allDevotees = [];

      if (widget.pageFrom == "Dashboard") {
        switch (widget.status) {
          case "allDevotee":
            allDevotee = await GetDevoteeAPI().allDevotee(1, 10);
            break;
          case "dataSubmitted":
            allDevotee = await GetDevoteeAPI()
                .searchDevotee("dataSubmitted", "status", 1, 10);
            break;
          case "Approved":
            allDevotee = await GetDevoteeAPI()
                .searchDevotee("Approved", "status", 1, 10);
            break;
          case "paid":
            allDevotee =
                await GetDevoteeAPI().searchDevotee("paid", "status", 1, 10);
            break;
          case "printed":
            allDevotee =
                await GetDevoteeAPI().searchDevotee("printed", "status", 1, 10);
            break;
          case "rejected":
            allDevotee = await GetDevoteeAPI()
                .searchDevotee("rejected", "status", 1, 10);
            break;
          case "blacklisted":
            allDevotee = await GetDevoteeAPI()
                .searchDevotee("blacklisted", "status", 1, 10);
            break;
          case "lost":
            allDevotee =
                await GetDevoteeAPI().searchDevotee("lost", "status", 1, 10);
            break;
          default:
        }
        for (int i = 0; i < allDevotee?["data"].length; i++) {
          allDevotees.add(allDevotee?["data"][i]);
        }
        print("******************** all devotees: ${allDevotees.length}");
        widget.onUpdateDevotee!(
          allDevotees,
          widget.status,
          "Dashboard",
          widget.searchBy,
          widget.searchValue,
          widget.showClearButton,
        );
      } else {
        if (widget.pageFrom == "Dashboard") {
          allDevotee = await GetDevoteeAPI().searchDevotee(
              widget.searchValue ?? selectedStatus,
              widget.searchBy ?? "status",
              1,
              10);
        } else {
          allDevotee = await GetDevoteeAPI().advanceSearchDevotee(
            widget.searchValue ?? selectedStatus,
            widget.searchBy ?? "status",
            1,
            dataCountPerPage,
            status: widget.advanceStatus ?? "",
          );
        }

        for (int i = 0; i < allDevotee["data"].length; i++) {
          allDevotees.add(allDevotee["data"][i]);
        }
        widget.onUpdateDevotee!(
          allDevotees,
          "allDevotee",
          "Search",
          widget.searchBy,
          widget.searchValue,
          widget.showClearButton,
        );
      }

      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        print("context is not mounted");
      }
    } on Exception catch (e) {
      print("some error: $e");
    }
  }

  void navigateToDevoteeListPage() async {
    Map<String, dynamic>? allDevotee = await GetDevoteeAPI().allDevotee(1, 10);
    List<DevoteeModel> allDevotees = [];
    for (int i = 0; i < allDevotee?["data"].length; i++) {
      allDevotees.add(allDevotee?["data"][i]);
    }
    totalPages = allDevotee?["totalPages"];
    dataCount = allDevotee?["count"];
    currentPage = allDevotee?["currentPage"];
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DevoteeListPage(
            status: "allDevotee",
            pageFrom: widget.pageFrom,
            devoteeList: allDevotees,
            searchValue: widget.searchValue,
            searchBy: widget.searchBy,
            showClearButton: widget.showClearButton,
            // currentPage: currentPage,
            // dataCount: dataCount,
            // totalPages: totalPages,
          ),
        ),
      );
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
      print("selected date parts: $selectedDateParts");
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

  void onStatusChanged(status) {
    setState(() {
      selectedStatus = status!;
      if (widget.title == "edit") {
        if (status == "delivered") {
          shouldShowdeliveredField = true;
          receivedByController.text = selectedDevotee?.name ?? "";
        }
        if (selectedDevotee?.paidAmount != null && status == "dataSubmitted") {
          shouldShowPranamiField = true;
          pranamiController.text =
              selectedDevotee?.paidAmount.toString() ?? "0";
        } else if (selectedDevotee?.paidAmount != null &&
            status == "approved") {
          shouldShowPranamiField = true;
          pranamiController.text =
              selectedDevotee?.paidAmount.toString() ?? "0";
        } else if (status == "dataSubmitted") {
          shouldShowPranamiField = false;
          pranamiController.text = "0";
        } else if (status == "approved") {
          shouldShowPranamiField = false;
          pranamiController.text = "0";
        } else if (status == "paid") {
          shouldShowPranamiField = true;
          pranamiController.text = "400";
        } else if (selectedDevotee?.paidAmount != null) {
          shouldShowPranamiField = true;
          pranamiController.text =
              selectedDevotee?.paidAmount.toString() ?? "0";
        } else {
          shouldShowPranamiField = false;
          pranamiController.text = "0";
        }
      }
    });
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
        width: 500,
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
                (widget.title == "edit" &&
                        (NetworkHelper().getCurrentDevotee?.role ==
                                "SuperAdmin" ||
                            NetworkHelper().getCurrentDevotee?.role ==
                                "Admin" ||
                            NetworkHelper().getCurrentDevotee?.role ==
                                "Approver"))
                    ? SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Status :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedStatus,
                                onChanged: onStatusChanged,
                                underline: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                items: NetworkHelper()
                                            .getCurrentDevotee
                                            ?.role ==
                                        "Approver"
                                    ? approverstatusOptions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList()
                                    : statusOptions
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                              ),
                            ),
                            //  SizedBox(height: 10),
                            // const VerticalDivider(
                            //   thickness: 1
                            // ),
                            //const SizedBox(width: 20),
                            (widget.title == "edit" &&
                                    NetworkHelper().getCurrentDevotee?.role ==
                                        "SuperAdmin")
                                ? const Text(
                                    "Role :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            (widget.title == "edit" &&
                                    NetworkHelper().getCurrentDevotee?.role ==
                                        "SuperAdmin")
                                ? Expanded(
                                    child: DropdownButton<String>(
                                      value: selectedRole,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedRole = newValue!;
                                        });
                                      },
                                      underline: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      items: roleList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                shouldShowPranamiField == true
                    ? const SizedBox(height: 20)
                    : const SizedBox(),
                shouldShowPranamiField == true
                    ? TextFormField(
                        keyboardType: TextInputType.phone,
                        // controller: widget.title == "edit"
                        //     ? pranamiController
                        //     : pranamiController
                        //   ..text = "700",
                        controller: pranamiController,
                        onSaved: (newValue) => pranamiController,
                        validator: (value) {
                          RegExp regex = RegExp(r'^[0-9]*$');
                          if (shouldShowPranamiField == true &&
                              value?.isEmpty == true) {
                            return "Please enter amount !";
                          }
                          if (!regex.hasMatch(value.toString())) {
                            return ("Only numbers are allowed !");
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          labelText: "Pranami (₹)",
                          labelStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.solid)),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                shouldShowdeliveredField == true
                    ? TextFormField(
                        keyboardType: TextInputType.name,
                        controller: receivedByController,
                        onSaved: (newValue) => receivedByController,
                        // validator: (value) {
                        //   if (shouldShowdeliveredField == true &&
                        //       value?.isEmpty == true) {
                        //     return "Please enter received By !";
                        //   }

                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: "Received By",
                          labelStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.solid)),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                shouldShowPranamiField == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Payment Mode',
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: RadioListTile(
                                      value: 0,
                                      groupValue: paymentModeIndex,
                                      title: const Text(
                                        "Cash",
                                      ),
                                      onChanged: (newValue) => setState(() =>
                                          paymentModeIndex = newValue ?? 0),
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
                                      groupValue: paymentModeIndex,
                                      title: const Text(
                                        "Online",
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          paymentModeIndex = newValue ?? 1;
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
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                const SizedBox(height: 20),

                (widget.title == "edit" && widget.role != "User")
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Organizer'),
                            Checkbox(
                              checkColor: Colors.deepOrange,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isOrganizer,
                              onChanged: (bool? value) {
                                setState(() {
                                  isOrganizer = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
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
                if (widget.role != "User")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Guest'),
                        Checkbox(
                          checkColor: Colors.deepOrange,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isGuest,
                          onChanged: (bool? value) {
                            setState(() {
                              isGuest = value!;
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
                      return null;
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
                // const SizedBox(height: 20),
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   controller: mobileController,
                //   onSaved: (newValue) => mobileController,
                // validator: (value) {
                //   RegExp regex = RegExp(r'^.{10}$');
                //   if (value!.isEmpty) {
                //     return null;
                //   }
                //   if (!regex.hasMatch(value) && value.length != 10) {
                //     return ("Enter 10 Digit Mobile Number");
                //   }
                //   return null;
                // },
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
                    print(phone.completeNumber);
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
                                      selectedAgeGroup = "13 to 70";
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
                // TextFormField(
                //     controller: ageController,
                //     //focusNode: ageFocusNode,
                //     onSaved: (newValue) => ageController,
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [
                //       FilteringTextInputFormatter.digitsOnly,
                //     ],
                //     decoration: InputDecoration(
                //       labelText: "Age",
                //       labelStyle:
                //           TextStyle(color: Colors.grey[600], fontSize: 15),
                //       filled: true,
                //       floatingLabelBehavior: FloatingLabelBehavior.auto,
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //           borderSide: const BorderSide(
                //               width: 0, style: BorderStyle.solid)),
                //     ),
                //   ),
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
                widget.title == "edit"
                    ? const SizedBox(height: 20)
                    : const SizedBox(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState == null ||
                          !formKey.currentState!.validate()) {
                        return;
                      }

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );

                      try {
                        await Future.delayed(const Duration(seconds: 1));
                        String? profileURL = await uploadProfileImage();

                        DevoteeModel updateDevotee =
                            buildDevoteeModel(profileURL);

                        Map<String, dynamic> response =
                            await submitDevoteeData(updateDevotee);

                        handleDevoteeSubmissionResponse(response);
                      } catch (e) {
                        handleException(e);
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
                    child: Text(
                      widget.title == "edit" ? "Update" : "Add",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
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
