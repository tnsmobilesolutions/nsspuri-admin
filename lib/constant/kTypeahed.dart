import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class KTypeahed extends StatefulWidget {
  KTypeahed(
      {Key? key,
      required this.controller,
      required this.itemBuilder,
      required this.lableText,
      required this.onsuggestionSelected,
      required this.suggestionsCallback})
      : super(key: key);
  TextEditingController controller;
  Function(String) suggestionsCallback;
  Function(Object?) onsuggestionSelected;
  String lableText = '';
  Function itemBuilder;

  @override
  State<KTypeahed> createState() => _KTypeahedState();
}

class _KTypeahedState extends State<KTypeahed> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          decoration: InputDecoration(
              labelText: widget.lableText, border: const OutlineInputBorder()
              // OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(15.0),
              // ),
              )),
      suggestionsCallback: (pattern) {
        // final sammilaniNumber =
        //     SammilaniUtility.getAllSammilaniName();
        // return sammilaniNumber.where((element) =>
        //     element.sammilaniNumber!.contains(pattern.toLowerCase()));
        return widget.suggestionsCallback(pattern);

        // return await BackendService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return widget.itemBuilder(suggestion);
      },
      getImmediateSuggestions: true,
      hideOnEmpty: false,
      noItemsFoundBuilder: (context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No Item Found'),
      ),
      onSuggestionSelected: (value) {
        widget.onsuggestionSelected(value);
      },
    );
  }
}
