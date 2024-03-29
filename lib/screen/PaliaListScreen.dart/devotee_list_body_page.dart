// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print
import 'dart:html' as html;
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/constant/pagination_value.dart';
import 'package:sdp/constant/printing_cards.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/download_image_page.dart';
import 'package:sdp/screen/PaliaListScreen.dart/export_to_excel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/pagination_row.dart';
import 'package:sdp/screen/PaliaListScreen.dart/shimmer.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/viewDevotee/preview_delegate.dart';
import 'package:sdp/screen/viewDevotee/viewDevotee.dart';
import 'package:sdp/utilities/network_helper.dart';

class DevoteeListBodyPage extends StatefulWidget {
  DevoteeListBodyPage({
    Key? key,
    required this.status,
    this.advanceStatus,
    this.pageFrom,
    this.devoteeList,
    this.showClearButton,
    this.searchValue,
    this.searchBy,
    this.currentPage,
    this.createdByMe,
    this.dataCount,
    this.totalPages,
  }) : super(key: key);

  String? advanceStatus;
  bool? createdByMe;
  List<DevoteeModel>? devoteeList;
  String? pageFrom;
  String? searchBy;
  String? searchValue;
  bool? showClearButton;
  String status;
  int? totalPages, dataCount, currentPage;

  @override
  State<DevoteeListBodyPage> createState() => _DevoteeListBodyPageState();
}

class _DevoteeListBodyPageState extends State<DevoteeListBodyPage>
    with TickerProviderStateMixin {
  bool? allCheck;
  List<DevoteeModel> allDevotees = [], selectedDevotees = [];
  bool checkedValue = false;
  Map<String, dynamic> data = {};
  bool editpaliDate = false;
  bool isAscending = true;
  bool isChecked = false;
  bool isLoading = true;
  bool isSelected = true;
  double downloadProgress = 0.0;
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

  List<bool> selectedList = [];
  bool showMenu = false;
  int totalPages = 0, dataCount = 0, currentPage = 1;
  String? userRole;

  int dataCountPerPage = RemoteConfigHelper().getDataCountPerPage;

  @override
  void initState() {
    super.initState();
    if (widget.devoteeList != null) {
      setState(() {
        isLoading = true;
        allDevotees = widget.devoteeList!;
        totalPages = widget.totalPages ?? 1;
        dataCount = widget.dataCount ?? 0;
        currentPage = widget.currentPage ?? 1;
        isLoading = false;
        userRole = NetworkHelper().currentDevotee?.role;
        selectedList =
            List<bool>.generate(allDevotees.length, (int index) => false);
      });
    } else {
      fetchAllDevotee(currentPage);
      setState(() {
        userRole = NetworkHelper().currentDevotee?.role;
      });
    }
    // fetchAllDevotee(currentPage);
    // if (widget.createdByMe != null && widget.createdByMe == true) {
    //   fetchDelegatesByMe();
    // } else {
    //   fetchAllDevotee(currentPage);
    //   setState(() {
    //     userRole = NetworkHelper().currentDevotee?.role;
    //   });
    // }
  }

  void downloadImage(String imageUrl) {
    final html.AnchorElement anchor = html.AnchorElement(href: imageUrl)
      ..target = 'image_download'
      ..download = 'image.jpg';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  }

  String formatDate(String inputDate) {
    if (inputDate.isNotEmpty) {
      DateTime dateTime = DateFormat('yyyy-MM-dd', 'en_US').parse(inputDate);

      int day = dateTime.day;
      String month = monthNames[dateTime.month - 1];
      int year = dateTime.year;

      String formattedDate = '$day-$month-$year';

      return formattedDate;
    }
    return "";
  }

  Future<void> fetchDelegatesByMe(int page) async {
    setState(() => isLoading = true);
    var currentUser = NetworkHelper().currentDevotee;
    Map<String, dynamic>? allDevotee;

    allDevotee = await GetDevoteeAPI().devoteeListBycreatedById(
        currentUser?.devoteeId.toString() ?? "", page, dataCountPerPage);
    if (allDevotee != null) {
      print("created by me: ${allDevotee.length}");
      allDevotees.clear();
      setState(() {
        for (int i = 0; i < allDevotee?["data"].length; i++) {
          allDevotees.add(allDevotee?["data"][i]);
        }
        totalPages = allDevotee?["totalPages"];
        dataCount = allDevotee?["count"];
        currentPage = allDevotee?["currentPage"];
        selectedList =
            List<bool>.generate(allDevotees.length, (int index) => false);
      });
    } else {
      print("Error in fetching created by me !");
    }
    setState(() => isLoading = false);
  }

  Future<void> fetchAllDevotee(int pageValue) async {
    setState(() => isLoading = true);

    Map<String, dynamic>? allDevotee;

    if (widget.pageFrom == "Dashboard") {
      if (widget.status == "allDevotee") {
        allDevotee = await GetDevoteeAPI().allDevotee(
          pageValue,
          dataCountPerPage,
          isAscending: NetworkHelper().getNameAscending,
        );
      } else {
        allDevotee = await GetDevoteeAPI().searchDevotee(
          widget.status,
          "status",
          pageValue,
          dataCountPerPage,
          isAscending: NetworkHelper().getNameAscending,
        );
      }
    } else {
      allDevotee = await GetDevoteeAPI().advanceSearchDevotee(
        widget.searchValue.toString(),
        widget.searchBy.toString(),
        pageValue,
        dataCountPerPage,
        status: widget.advanceStatus,
        isAscending: NetworkHelper().getNameAscending,
      );
    }

    //  if (widget.pageFrom == "Search")

    if (allDevotee != null) {
      allDevotees.clear();
      setState(() {
        for (int i = 0; i < allDevotee?["data"].length; i++) {
          allDevotees.add(allDevotee?["data"][i]);
        }
        totalPages = allDevotee?["totalPages"];
        dataCount = allDevotee?["count"];
        currentPage = allDevotee?["currentPage"];
        selectedList =
            List<bool>.generate(allDevotees.length, (int index) => false);
        // print("count: $dataCount");
        // print("totalPages: $totalPages");
        // print("currentPage: $currentPage");
      });
    } else {
      print("Error fetching data");
    }

    setState(() => isLoading = false);
  }

  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

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

  String getAgeGroup(DevoteeModel? devotee) {
    if (devotee?.ageGroup?.isNotEmpty == true || devotee?.ageGroup != null) {
      if (devotee?.ageGroup == "Child") {
        return "1 to 12";
      } else if (devotee?.ageGroup == "Adult") {
        return "13 to 70";
      } else if (devotee?.ageGroup == "Elder") {
        return "70 Above";
      }
    }
    return "";
  }

  String getSLno(int index) {
    List<int> slList = List.generate(
      dataCountPerPage,
      (index) => (currentPage - 1) * dataCountPerPage + index + 1,
    );
    return slList[index].toString();
  }

  Widget devoteeTable(BuildContext context) {
    return DataTable(
      showBottomBorder: true,
      showCheckboxColumn: isChecked == true ? true : false,
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
        DataColumn(
          label: Row(
            children: [
              Text(
                'Devotee Name',
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                      const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    isAscending = !isAscending;
                    NetworkHelper().setNameAscending = isAscending;
                  });
                  await fetchAllDevotee(currentPage);
                },
                icon: Icon(
                  NetworkHelper().getNameAscending
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: Colors.deepOrange,
                ),
              ),
              // AnimateIcons(
              //   startIcon: Ionicons.arrow_up,
              //   endIcon: Ionicons.arrow_down,
              //   startIconColor: Colors.deepOrange,
              //   endIconColor: Colors.deepOrange,
              //   controller: _controller,
              //   duration: const Duration(milliseconds: 800),
              //   size: 20.0,
              //   onStartIconPress: () {
              //     isAscending = !isAscending;
              //     NetworkHelper().setNameAscending = isAscending;
              //     //_sortList(isAscending);
              //     return true;
              //   },
              //   onEndIconPress: () {
              //     isAscending = !isAscending;
              //     NetworkHelper().setNameAscending = isAscending;
              //     // _sortList(isAscending);
              //     return true;
              //   },
              // ),
            ],
          ),
        ),
        dataColumn(context, 'Sangha'),
        dataColumn(context, 'DOB/Age Group'),
        dataColumn(context, 'Status'),
        dataColumn(context, 'View'),
        if (NetworkHelper().getCurrentDevotee?.role == "Admin" ||
            NetworkHelper().getCurrentDevotee?.role == "SuperAdmin" ||
            NetworkHelper().getCurrentDevotee?.role == "Approver")
          dataColumn(context, 'Print'),
        if (NetworkHelper().getCurrentDevotee?.role != "Viewer")
          dataColumn(context, 'Edit'),
        dataColumn(context, '14th Event Info'),
      ],
      rows: List.generate(
        allDevotees.length,
        (index) {
          return DataRow(
            selected: selectedList[index],
            onSelectChanged: (bool? value) {
              setState(() {
                selectedList[index] = value!;
                if (value) {
                  if (selectedDevotees.length < 7) {
                    selectedDevotees.add(allDevotees[index]);
                    print("selected : $selectedDevotees");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      elevation: 6,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'You can only select up to 7 devotees !',
                      ),
                    ));
                    selectedList[index] = false;
                  }
                } else {
                  selectedDevotees.remove(allDevotees[index]);
                }
              });
            },
            cells: [
              DataCell(Text(getSLno(index))),
              // DataCell(Text("${index + 1}")),
              DataCell(SizedBox(
                height: 50,
                width: 50,
                child: allDevotees[index].profilePhotoUrl != null &&
                        allDevotees[index].profilePhotoUrl!.isNotEmpty == true
                    ? Image.network(
                        allDevotees[index].profilePhotoUrl ?? '',
                        height: 80,
                        width: 80,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Icon(Icons.error);
                        },
                      )
                    : const Image(
                        image: AssetImage('assets/images/profile.jpeg')),
              )),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allDevotees[index].name != null
                          ? '${allDevotees[index].name}'
                          : "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      allDevotees[index].devoteeCode.toString(),
                    ),
                  ],
                ),
              ),
              DataCell(Text(allDevotees[index].sangha ?? "")),
              DataCell(
                allDevotees[index].dob?.isNotEmpty == true
                    ? Text(
                        formatDate(allDevotees[index].dob ?? ""),
                        textAlign: TextAlign.center,
                      )
                    : (allDevotees[index].ageGroup?.isNotEmpty == true ||
                            allDevotees[index].ageGroup != null)
                        ? Text(
                            getAgeGroup(allDevotees[index]),
                            textAlign: TextAlign.center,
                          )
                        : const Text(""),
              ),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${allDevotees[index].status}'),
                    allDevotees[index].paidAmount != null
                        ? Text('₹${allDevotees[index].paidAmount}')
                        : const SizedBox(),
                  ],
                ),
              ),
              DataCell(
                IconButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(allDevotees[index].name.toString()),
                            allDevotees[index].sangha != null &&
                                    allDevotees[index].sangha != ''
                                ? Text(
                                    "(${allDevotees[index].sangha.toString()})")
                                : const Text(''),
                            const Spacer(),
                            IconButton(
                                color: Colors.deepOrange,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        content:
                            ViewDevotee(devoteeDetails: allDevotees[index]),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info, color: Colors.deepOrange),
                ),
              ),
              if (NetworkHelper().getCurrentDevotee?.role == "Admin" ||
                  NetworkHelper().getCurrentDevotee?.role == "SuperAdmin" ||
                  NetworkHelper().getCurrentDevotee?.role == "Approver")
                DataCell(IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PreviewDelegateTab(
                          devoteeDetails: allDevotees[index]);
                    }));
                  },
                  icon: const Icon(
                    Icons.print,
                    color: Colors.deepOrange,
                  ),
                )),
              if (NetworkHelper().getCurrentDevotee?.role != "Viewer")
                DataCell(
                  IconButton(
                    color: Colors.deepOrange,
                    onPressed: NetworkHelper().currentDevotee?.role ==
                                "Approver" &&
                            (allDevotees[index].status == "paid" ||
                                allDevotees[index].status == "printed" ||
                                allDevotees[index].status == "withdrawn" ||
                                allDevotees[index].status == "lost" ||
                                allDevotees[index].status == "reissued" ||
                                allDevotees[index].status == "blacklisted")
                        ? null
                        : () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Edit Devotee Details'),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.deepOrange,
                                            ))
                                      ],
                                    ),
                                    content: AddPageDilouge(
                                      devoteeId: allDevotees[index]
                                          .devoteeId
                                          .toString(),
                                      title: "edit",
                                      onUpdateDevotee: (
                                        allVakta,
                                        status,
                                        pageFrom,
                                        searchBy,
                                        searchValue,
                                        showClearButton,
                                      ) {
                                        setState(() {
                                          allDevotees = allVakta;
                                          widget.status = status.toString();
                                          widget.pageFrom = pageFrom.toString();
                                          widget.searchBy = widget.searchBy;
                                          widget.searchValue = searchValue;
                                          widget.showClearButton =
                                              showClearButton;
                                        });
                                      },
                                      showClearButton: widget.showClearButton,
                                      status: widget.status,
                                      advanceStatus: widget.advanceStatus,
                                      pageFrom: widget.pageFrom,
                                      searchBy: widget.searchBy,
                                      searchValue: widget.searchValue,
                                    ));
                              },
                            );
                          },
                    icon: Icon(
                      Icons.edit,
                      color: ((NetworkHelper().currentDevotee?.role ==
                                      "Approver" &&
                                  (allDevotees[index].status == "paid" ||
                                      allDevotees[index].status == "printed" ||
                                      allDevotees[index].status ==
                                          "withdrawn" ||
                                      allDevotees[index].status == "lost" ||
                                      allDevotees[index].status == "reissued" ||
                                      allDevotees[index].status ==
                                          "blacklisted")) ||
                              (NetworkHelper().getCurrentDevotee?.role ==
                                  "Viewer"))
                          ? const Color.fromARGB(255, 206, 206, 206)
                          : Colors.deepOrange,
                    ),
                  ),
                ),
              DataCell(IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmation"),
                        content: Text("Are you coming to 14th Event?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Close the dialog and do nothing
                              Navigator.of(context).pop();
                            },
                            // onPressed: () {
                            //   // Close the dialog and proceed
                            //   Navigator.of(context).pop();
                            //   // Navigate to the PreviewDelegateTab
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) {
                            //       return PreviewDelegateTab(
                            //           devoteeDetails: allDevotees[index]);
                            //     }),
                            //   );
                            // },
                            child: Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Close the dialog and do nothing
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.deepOrange,
                ),
              ))
            ],
          );
        },
      ),
    );
  }

  // void _sortList(bool isAscending) {
  //   setState(() {
  //     allDevotees.sort((a, b) {
  //       final nameA = (a.name ?? '').toLowerCase();
  //       final nameB = (b.name ?? '').toLowerCase();
  //       return isAscending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
  //     });
  //   });
  // }

  // void _exportToExcelHandler() async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) =>
  //         const Center(child: CircularProgressIndicator()),
  //   );

  //   try {
  //     List<DevoteeModel> devoteeList = [];

  //     if (widget.createdByMe == true) {
  //       var currentUser = NetworkHelper().currentDevotee;
  //       final createdById = currentUser?.createdById.toString() ?? "";
  //       final result = await GetDevoteeAPI().devoteeListBycreatedById(
  //           createdById, 1, 10000,
  //           isAscending: NetworkHelper().getNameAscending);
  //       if (result != null && result.containsKey("data")) {
  //         devoteeList.addAll(result["data"]);
  //       }
  //     } else if (widget.pageFrom == "Dashboard") {
  //       final isAllDevotee = widget.status == "allDevotee";
  //       final result = isAllDevotee
  //           ? await GetDevoteeAPI().allDevotee(1, 10000,
  //               isAscending: NetworkHelper().getNameAscending)
  //           : await GetDevoteeAPI().searchDevotee(
  //               widget.status, "status", 1, 10000,
  //               isAscending: NetworkHelper().getNameAscending);
  //       if (result != null && result.containsKey("data")) {
  //         devoteeList.addAll(result["data"]);
  //       }
  //     } else {
  //       final result = await GetDevoteeAPI().advanceSearchDevotee(
  //           widget.searchValue.toString(), widget.searchBy.toString(), 1, 10000,
  //           status: widget.advanceStatus,
  //           isAscending: NetworkHelper().getNameAscending);
  //       if (result.isNotEmpty && result.containsKey("data")) {
  //         devoteeList.addAll(result["data"]);
  //       }
  //     }

  //     if (context.mounted) {
  //       Navigator.pop(context);
  //     }
  //     ExportToExcel().exportToExcel(devoteeList);
  //   } catch (e) {
  //     print("Error: $e");
  //     // Handle error appropriately, like showing an error dialog
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? const AnimatedShimmerWidget()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  userRole == "SuperAdmin" ||
                          userRole == "Admin" ||
                          userRole == "Approver"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isSelected == true
                                ? OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1.5,
                                            color: Colors.deepOrange),
                                        foregroundColor: Colors.black),
                                    onPressed: (NetworkHelper()
                                                .getCurrentDevotee
                                                ?.role !=
                                            "Viewer")
                                        ? () {
                                            setState(() {
                                              isChecked = true;
                                              isSelected = false;
                                            });
                                          }
                                        : null,
                                    child: const Text('Select'),
                                  )
                                : OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1.5,
                                            color: Colors.deepOrange),
                                        foregroundColor: Colors.black),
                                    onPressed: (NetworkHelper()
                                                .getCurrentDevotee
                                                ?.role !=
                                            "Viewer")
                                        ? () {
                                            DisplayPdf.delegatePDF(
                                                selectedDevotees, context);
                                          }
                                        : null,
                                    child: const Text('Print'),
                                  ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 1.5, color: Colors.deepOrange),
                                  foregroundColor: Colors.black),
                              onPressed:
                                  (NetworkHelper().getCurrentDevotee?.role !=
                                          "Viewer")
                                      ? () {
                                          ExportToExcel()
                                              .exportToExcel(allDevotees);
                                        }
                                      : null,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Export'),
                                  Icon(
                                    Icons.upload_rounded,
                                    color: Colors.deepOrange,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Responsive(
                              desktop: devoteeTable(context),
                              tablet: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: devoteeTable(context),
                              ),
                              mobile: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: devoteeTable(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      PaginationRow(
                        dataCount: dataCount,
                        dataLimit: dataCountPerPage,
                        currentPage: currentPage,
                        totalPages: totalPages,
                        fetchAllDevotee: (page) {
                          // if (widget.devoteeList != null) {
                          //   fetchDelegatesByMe(page);
                          // } else {
                          //   fetchAllDevotee(page);
                          // }
                          if (widget.createdByMe == true) {
                            fetchDelegatesByMe(page);
                          } else {
                            fetchAllDevotee(page);
                          }
                        },
                        onFieldSubmitted: (page) {
                          if (page != null &&
                              int.tryParse(page)! > 0 &&
                              int.tryParse(page)! <= totalPages) {
                            // if (widget.devoteeList != null) {
                            //   fetchDelegatesByMe(int.tryParse(page) ?? 1);
                            // } else {
                            if (widget.createdByMe == true) {
                              fetchDelegatesByMe(int.tryParse(page) ?? 1);
                            } else {
                              fetchAllDevotee(int.tryParse(page) ?? 1);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
