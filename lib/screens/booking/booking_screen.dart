import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rdcciappointment/screens/booking/pre_confimation_screen.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool _timeSlotLoading = false;
  int selectedSlotId = 0;
  List<dynamic> availableTimes = [
    {"id": 1, "slot": "10 AM", "availability": 10},
    {"id": 2, "slot": "11 AM", "availability": 10},
    {"id": 3, "slot": "12 PM", "availability": 0},
    {"id": 4, "slot": "1.30 PM", "availability": 10},
    {"id": 5, "slot": "2.30 PM", "availability": 1},
    {"id": 6, "slot": "3.30 PM", "availability": 0},
    {"id": 7, "slot": "4.30 PM", "availability": 5},
    {"id": 8, "slot": "5.30 PM", "availability": 6},
    {"id": 9, "slot": "6.30 PM", "availability": 3}
  ];

  void _changedDate() async {
    setState(() {
      _timeSlotLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _timeSlotLoading = false;
    });
  }

  void _selectedSlot(dynamic cTime) {
    setState(() {
      selectedSlotId = cTime['id'];
    });
  }

  void _proceedAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreConfirmationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeaeaea),
      appBar: AppBar(
        title: Text(
          'Appointment Booking',
          //style: TextStyle(fontSize: 16),
        ),
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        'User Verification',
                        minFontSize: 20,
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "National ID / Iqama No",
                      contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: AutoSizeText(
                                'Appointment Information',
                                minFontSize: 20,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 10,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          //color: Colors.green.withOpacity(.3),
                        ),
                        child: DatePicker(
                          DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Theme.of(context).primaryColor,
                          selectedTextColor: Colors.white,
                          daysCount: 30,
                          onDateChange: (date) {
                            print(date);
                            this._changedDate();
                            // New date selected
//                          setState(() {
//                            _selectedValue = date;
//                          });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 20,
                        ),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 20,
                            childAspectRatio: 2,
                          ),
                          itemCount: this.availableTimes.length,
                          itemBuilder: (BuildContext context, int index) {
                            var cTime = this.availableTimes[index];
                            return InkWell(
                              onTap: cTime['availability'] > 0
                                  ? () {
                                      this._selectedSlot(cTime);
                                    }
                                  : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: selectedSlotId == cTime['id'] ? Colors.green : Colors.white,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: AutoSizeText(
                                          cTime['slot'],
                                          minFontSize: 10,
                                          maxFontSize: 22,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: selectedSlotId == cTime['id']
                                                ? Colors.white
                                                : (cTime['availability'] > 1 ? Theme.of(context).primaryColor : Colors.red),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      _timeSlotLoading
                          ? Positioned(
                              top: 50,
                              left: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .9,
                                child: Center(
                                  child: SpinKitWave(
                                    color: Theme.of(context).primaryColor,
                                    type: SpinKitWaveType.start,
                                    size: 50,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  //color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.width / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    //color: Colors.red,
                    height: 62,
                    child: FlatButton(
                      onPressed: _proceedAppointment,
                      color: Theme.of(context).primaryColor,
                      child: AutoSizeText(
                        'Proceed Appointment'.toUpperCase(),
                        minFontSize: 18,
                        maxFontSize: 22,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
