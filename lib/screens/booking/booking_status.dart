import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/main.dart';
import 'package:rdcciappointment/models/booking_confirm/bookingData.dart';
import 'package:rdcciappointment/screens/home_screen.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class BookingStatus extends StatefulWidget {
  final BookingData bookingData;

  const BookingStatus({Key key, this.bookingData}) : super(key: key);

  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  String currentLanguage = 'en';
  AppointmentServices appointmentServices = new AppointmentServices();

  reloadToHome() async {
    await Future.delayed(Duration(seconds: 1));

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> r) => false);
  }

  Future<void> _cancelBooking() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(getTranslate(context, 'are_you_sure_to_cancel_this_booking')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(getTranslate(context, 'once_you_are_canceled_the_booking_it_would_not_able_to_revert_back')),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(getTranslate(context, 'cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(getTranslate(context, 'confirm')),
              onPressed: () async {
                final Map<String, dynamic> cancelData = {"NationalIdOrIQAMA": this.widget.bookingData.nationalIdOrIQAMA, "Id": this.widget.bookingData.id};
                bool response = await this.appointmentServices.cancelAppointment(cancelData);
                //print(response);
                this.reloadToHome();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this._loadClient();
  }

  void _loadClient() async {
    currentLanguage = MyApp.getCurrentLocal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(getTranslate(context, 'booking_status')),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            },
            color: Colors.white,
            icon: Icon(Icons.home),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .7,
                      color: Color(0xfffdfdfd),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * .7,
                                    height: MediaQuery.of(context).size.width * .7,
                                    color: Colors.grey,
                                    padding: EdgeInsets.all(2),
                                    child: Container(
                                      color: Colors.white,
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=' + this.widget.bookingData.qrCode + '&choe=UTF-8',
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) => Center(
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'booking_date'),
                                    value: this.widget.bookingData.formattedDate,
                                  ),
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'time_slot'),
                                    value: this.widget.bookingData.bookingSlot,
                                  ),
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'name'),
                                    value: this.widget.bookingData.visitorName,
                                  ),
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'id_number'),
                                    value: this.widget.bookingData.nationalIdOrIQAMA.toString(),
                                  ),
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'branch'),
                                    value: currentLanguage == 'en'
                                        ? this.widget.bookingData.bookingBranch.branchNameEnglish
                                        : this.widget.bookingData.bookingBranch.branchNameArabic,
                                  ),
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'branch_address'),
                                    value: currentLanguage == 'en'
                                        ? this.widget.bookingData.bookingBranch.addressEnglish
                                        : this.widget.bookingData.bookingBranch.addressArabic,
                                  ),
                                  AppointmentDetailTile(
                                    keyItem: getTranslate(context, 'services'),
                                    value: this.widget.bookingData.serviceNames(this.currentLanguage),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: FlatButton(
                                    color: Colors.red,
                                    onPressed: _cancelBooking,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: AutoSizeText(
                                        getTranslate(context, 'cancel_appointment'),
                                        minFontSize: 16,
                                        style: TextStyle(
                                          color: Colors.white,
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentDetailTile extends StatelessWidget {
  final String keyItem;
  final String value;
  const AppointmentDetailTile({Key key, this.keyItem, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: AutoSizeText(
                keyItem ?? '',
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: AutoSizeText(
                value ?? '',
                maxLines: 4,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
