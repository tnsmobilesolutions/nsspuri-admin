import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdp/model/devotee_model.dart';

class ViewPalia extends StatefulWidget {
  const ViewPalia({Key? key, required this.devoteeDetails}) : super(key: key);
  final DevoteeModel devoteeDetails;

  @override
  State<ViewPalia> createState() => _ViewPaliaState();
}

class _ViewPaliaState extends State<ViewPalia>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // 2 tabs in this example
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      width: 500,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  "Devotee Info",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Sammilani Delegate Info",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1 content
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Container(
                        margin: EdgeInsets.only(right: 300),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          style: Theme.of(context).textTheme.displaySmall,
                          controller: nameController,
                          onSaved: (newValue) => nameController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-z A-Z]"))
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                  ],
                ),
                // Tab 2 content
                Center(
                  child: Text('Sammilani Delegate Info',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
