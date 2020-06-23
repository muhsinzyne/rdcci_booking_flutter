import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rdcciappointment/screens/booking/booking_screen.dart';
import 'package:rdcciappointment/screens/components/search_box.dart';

class DepartmentSelectionScreen extends StatefulWidget {
  @override
  _DepartmentSelectionScreenState createState() =>
      _DepartmentSelectionScreenState();
}

class _DepartmentSelectionScreenState extends State<DepartmentSelectionScreen> {
  final List<dynamic> department = [
    {"name": "Chamber IT", "image": 'asset/images/computer.png'},
    {"name": "Training", "image": 'asset/images/webinar.png'},
    {"name": "Business", "image": 'asset/images/idea.png'},
    {"name": "Commercial", "image": 'asset/images/money.png'},
    {"name": "Conference", "image": 'asset/images/speaking.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        //color: Theme.of(context).primaryColor,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(
              children: <Widget>[
                SearchBox(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: this.department.length,
                    itemBuilder: (BuildContext context, int index) {
                      var cDepartment = this.department[index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(cDepartment['image']),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: AutoSizeText(
                                            cDepartment['name'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
