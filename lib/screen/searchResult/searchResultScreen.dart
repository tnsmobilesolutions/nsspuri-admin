// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/searchResult/searchBody.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key? key, required this.searchReslt}) : super(key: key);
  List<DevoteeModel> searchReslt;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const LeadingImage(),
        automaticallyImplyLeading: false,
        title: const Text(
          'nsspuri-admin',
        ),
        actions: const [ActionWidget()],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SearchresultBodyPage(
            searchModel: widget.searchReslt,
          ))
        ],
      )),
    );
  }
}
