import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/main.dart';
import 'package:rdcciappointment/models/booking_confirm/bookingResponse.dart';
import 'package:rdcciappointment/models/index.dart';
import 'package:rdcciappointment/models/services/services.dart';
import 'package:rdcciappointment/providers/global_provider.dart';
import 'package:rdcciappointment/screens/animations/ui_animations.dart';
import 'package:rdcciappointment/screens/booking/booking_status.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class PreConfirmationScreen extends StatefulWidget {
  final String nationalId;
  final String visitorName;
  final String visitorEmail;
  final List<dynamic> selectedServiceList;
  final Slot selectedSlot;
  const PreConfirmationScreen({Key key, this.nationalId, this.visitorName, this.visitorEmail, this.selectedServiceList, this.selectedSlot}) : super(key: key);

  @override
  _PreConfirmationScreenState createState() => _PreConfirmationScreenState();
}

class _PreConfirmationScreenState extends State<PreConfirmationScreen> {
  GlobalProvider _globalProvider;
  String currentLanguage = 'en';
  var timeFormat = DateFormat('Hm');
  var dateFormat = DateFormat.yMMMMd('en_US');
  var dbDateFormat = DateFormat('yyyy-MM-dd');
  var parsedDate;
  var bookingTime;
  var bookingDate;
  AppointmentServices appointmentServices = new AppointmentServices();

  @override
  void initState() {
    super.initState();
    this._loadClient();
  }

  @override
  void didChangeDependencies() {
    _globalProvider = Provider.of<GlobalProvider>(context, listen: true);
    super.didChangeDependencies();
  }

  void _loadClient() async {
    currentLanguage = MyApp.getCurrentLocal(context);
    parsedDate = DateTime.parse(this.widget.selectedSlot.slotDate);
    bookingTime = timeFormat.format(parsedDate);
    bookingDate = dateFormat.format(parsedDate);
  }

  void _bookNow() async {
    _globalProvider.loader = true;
    var bodyParams = this.getBodyObject();
    BookingResponse response = await appointmentServices.bookAppointment(bodyParams);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingStatus(
            bookingData: response.data,
          ),
        ),
      );
    } else if (response.statusCode == 409) {
      _showMyDialog(response.statusMessage);
    } else {
      _showMyDialog(getTranslate(context, 'you_having_an_existing_booking_or_booking_slot_is_very_busy'));
    }
    _globalProvider.loader = false;
  }

  _showMyDialog(String stringValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(getTranslate(context, 'error')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(getTranslate(context, 'your_booking_could_not_be_proceeded_due_to')),
                Text(stringValue ?? ''),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(getTranslate(context, 'ok')),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  dynamic getBodyObject() {
    final Map<String, dynamic> bodyData = {
      "NationalIdOrIQAMA": int.parse(this.widget.nationalId),
      "BookingDate": dbDateFormat.format(parsedDate),
      "BookingSlot": bookingTime,
      "BranchAvailabilityTimeSlotId": 1,
      "BranchId": _globalProvider.selectedBranch.id,
      "Status": 1,
      "English": currentLanguage == 'en' ? true : false,
      "VisitorName": this.widget.visitorName,
      "EmailAddress": this.widget.visitorEmail,
      "Services": null
    };
    final List<dynamic> postServiceList = [];
    for (int i = 0; i < this.widget.selectedServiceList.length; i++) {
      final Services loopService = this.widget.selectedServiceList[i];
      if (loopService.isOtherActivated == true) {
        postServiceList.add({"ServiceId": loopService.id, "OtherServiceText": loopService.otherValue.toString()});
      } else {
        postServiceList.add({"ServiceId": loopService.id, "OtherServiceText": ''});
      }
    }
    bodyData['Services'] = postServiceList;
    return bodyData;
  }

  String convertServicesList() {
    var serviceNameStrings = '';
    this.widget.selectedServiceList.forEach((element) {
      final Services loopService = element;
      if (loopService.isOtherActivated == true) {
        serviceNameStrings += loopService.otherValue;
      } else {
        serviceNameStrings += (currentLanguage == 'en') ? loopService.serviceNameEnglish : loopService.serviceNameArabic;
      }
      serviceNameStrings += '\n ';
    });
    return serviceNameStrings;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _globalProvider.loader,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(getTranslate(context, 'confirm_appointment')),
          elevation: 0,
        ),
        body: getPageContents(),
      ),
      progressIndicator: PageLoadingAnimation(
        style: LoadingAnimationStyle.style1,
        size: 60,
      ),
    );
  }

  Widget getPageContents() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      'asset/images/logo.png',
                    ),
                  ),
                ),
                radius: 80,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  height: 180,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: AutoSizeText(
                                  currentLanguage == 'en' ? _globalProvider.selectedBranch.branchNameEnglish : _globalProvider.selectedBranch.branchNameArabic,
                                  textAlign: TextAlign.center,
                                  minFontSize: 18,
                                  maxFontSize: 24,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: AutoSizeText(
                                  currentLanguage == 'en' ? _globalProvider.selectedBranch.addressEnglish : _globalProvider.selectedBranch.addressArabic,
                                  textAlign: TextAlign.center,
                                  minFontSize: 12,
                                  maxFontSize: 18,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: AutoSizeText(
                                  getTranslate(context, 'services'),
                                  textAlign: TextAlign.center,
                                  minFontSize: 12,
                                  maxFontSize: 18,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: AutoSizeText(
                                  convertServicesList(),
                                  textAlign: TextAlign.center,
                                  minFontSize: 16,
                                  maxFontSize: 20,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  CListItem(
                    label: getTranslate(context, 'id_number'),
                    value: this.widget.nationalId,
                  ),
                  Divider(),
                  CListItem(
                    label: getTranslate(context, 'full_name'),
                    value: this.widget.visitorName,
                  ),
                  Divider(),
                  CListItem(
                    label: getTranslate(context, 'date'),
                    value: bookingDate ?? '',
                  ),
                  Divider(),
                  CListItem(
                    label: getTranslate(context, 'time_slot'),
                    value: bookingTime ?? '00:00',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      color: Colors.green,
                      onPressed: _bookNow,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: AutoSizeText(
                                getTranslate(context, 'book_now'),
                                textAlign: TextAlign.center,
                                minFontSize: 20,
                                maxFontSize: 28,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/botton_crop.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CListItem extends StatelessWidget {
  const CListItem({
    Key key,
    this.label = '',
    this.value = '',
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: AutoSizeText(
              label,
              minFontSize: 12,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(
              value,
              minFontSize: 12,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
