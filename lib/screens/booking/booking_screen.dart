import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/models/index.dart';
import 'package:rdcciappointment/screens/booking/pre_confimation_screen.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class BookingScreen extends StatefulWidget {
  final int selectedBranch;
  final String nationalId;
  final String visitorName;
  final String visitorEmail;
  final List<dynamic> selectedServiceList;

  const BookingScreen({Key key, this.selectedBranch, this.nationalId, this.visitorName, this.visitorEmail, this.selectedServiceList}) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  AppointmentServices appointmentServices = new AppointmentServices();
  TimeSlotResponse timeSlotResponse;
  Slot selectedSlot;
  bool _timeSlotLoading = false;
  int selectedSlotId;
  String requestedDate = '';
  var dateFormatter = new DateFormat('yyyy-MM-dd');
  var timeFormat = DateFormat('Hm');

  void _changedDate() async {
    selectedSlotId = null;
    selectedSlot = null;
    setState(() {
      _timeSlotLoading = true;
    });

    await this.timeSlotFetch();
    setState(() {
      _timeSlotLoading = false;
    });
  }

  void _selectedSlot(Slot cSlot) {
    setState(() {
      selectedSlotId = cSlot.id;
      selectedSlot = cSlot;
    });
  }

  void _proceedAppointment() {
    if (selectedSlotId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreConfirmationScreen(
            selectedServiceList: this.widget.selectedServiceList,
            visitorName: this.widget.visitorName,
            visitorEmail: this.widget.visitorEmail,
            nationalId: this.widget.nationalId,
            selectedSlot: selectedSlot,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: getTranslate(context, 'please_select_a_available_slot_to_continue'),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this.initDate();
    this._loadClient();
  }

  void initDate() {
    var now = DateTime.now();
    String date = dateFormatter.format(now);
    setState(() {
      requestedDate = date;
      //requestedDate = '2020-08-17';
    });
  }

  void _loadClient() async {
    Future.delayed(Duration(microseconds: 500));
    timeSlotFetch();
  }

  timeSlotFetch() async {
    TimeSlotResponse response = await appointmentServices.getTimeSlots(branchId: this.widget.selectedBranch.toString(), date: requestedDate);

    if (response.slots != null) {
      if (response.slots.length > 0) {
        setState(() {
          timeSlotResponse = response;
        });
      } else {
        setState(() {
          timeSlotResponse.slots = [];
        });
      }
    } else {
      setState(() {
        timeSlotResponse.slots = [];
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeaeaea),
      appBar: AppBar(
        title: Text(getTranslate(context, 'appointment_booking')
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
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: AutoSizeText(
                                getTranslate(context, 'appointment_information'),
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
                            var formatter = new DateFormat('yyyy-MM-dd');
                            String changedDate = formatter.format(date);
                            setState(() {
                              requestedDate = changedDate;
                            });
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
                        child: (timeSlotResponse?.slots?.length ?? 0) == 0
                            ? noSlotsAvailable()
                            : GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 2,
                                ),
                                itemCount: timeSlotResponse?.slots?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  print(index);
                                  final Slot cSlot = timeSlotResponse.slots[index];
                                  cSlot.id = index;
                                  print(cSlot.slotDate);
                                  var parsedDate = DateTime.parse(cSlot.slotDate);
                                  final String bookingTime = timeFormat.format(parsedDate);
                                  //print(formatted);
                                  return InkWell(
                                    onTap: cSlot.bookCount == 0
                                        ? () {
                                            this._selectedSlot(cSlot);
                                          }
                                        : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: selectedSlotId == cSlot.id ? Colors.green : Colors.white,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: AutoSizeText(
                                                bookingTime,
                                                minFontSize: 10,
                                                maxFontSize: 22,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: selectedSlotId == cSlot.id
                                                      ? Colors.white
                                                      : (cSlot.bookCount == 0 ? Theme.of(context).primaryColor : Colors.red),
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
                      onPressed: selectedSlotId != null ? _proceedAppointment : () {},
                      color: selectedSlotId != null ? Theme.of(context).primaryColor : Colors.grey,
                      child: AutoSizeText(
                        getTranslate(context, 'proceed_appointment'),
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

  Widget noSlotsAvailable() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: AutoSizeText(
          getTranslate(context, 'no_slots_are_available'),
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
