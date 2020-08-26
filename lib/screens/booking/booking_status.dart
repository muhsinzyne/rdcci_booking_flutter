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
//                            Container(
//                              margin: EdgeInsets.symmetric(vertical: 10),
//                              child: TicketPass(
//                                alignment: Alignment.center,
//                                animationDuration: Duration(milliseconds: 200),
//                                separatorColor: Colors.black,
//                                separatorHeight: 2.0,
//                                color: Colors.white,
//                                curve: Curves.easeOut,
//                                expandIcon: Icon(
//                                  Icons.info,
//                                  color: Colors.white,
//                                  size: 0,
//                                ),
//                                titleColor: Colors.white,
//                                ticketTitle: Text(
//                                  '',
//                                ),
//                                titleHeight: 0,
//                                width: 350,
//                                height: 420,
//                                shadowColor: Colors.white.withOpacity(0.5),
//                                elevation: 8,
//                                shouldExpand: false,
//                                child: Padding(
//                                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
//                                  child: Column(
//                                    children: <Widget>[
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.end,
//                                        children: <Widget>[
//                                          Container(
//                                            width: 220,
//                                            height: 220,
//                                            decoration: BoxDecoration(
//                                              image: DecorationImage(
//                                                image: NetworkImage('https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=' +
//                                                    this.widget.bookingData.qrCode +
//                                                    '&choe=UTF-8'),
//                                                fit: BoxFit.cover,
//                                              ),
//                                            ),
//                                          )
//                                        ],
//                                      ),
//                                      SizedBox(
//                                        height: 20,
//                                      ),
//                                      Container(
//                                        height: 160,
//                                        child: Padding(
//                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
//                                          child: Column(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              Expanded(
//                                                child: Container(
//                                                  child: Row(
//                                                    children: <Widget>[
//                                                      Expanded(
//                                                        child: Column(
//                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                                          children: <Widget>[
//                                                            Text(
//                                                              getTranslate(context, 'appointment_time'),
//                                                              style: TextStyle(color: Colors.black.withOpacity(0.5)),
//                                                            ),
//                                                            Text(
//                                                              this.widget.bookingData.bookingSlot,
//                                                              style: TextStyle(fontWeight: FontWeight.w600),
//                                                            ),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                      Expanded(
//                                                        child: Column(
//                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                                          children: <Widget>[
//                                                            Text(
//                                                              getTranslate(context, 'name'),
//                                                              style: TextStyle(
//                                                                color: Colors.black.withOpacity(0.5),
//                                                              ),
//                                                            ),
//                                                            Text(
//                                                              this.widget.bookingData.visitorName,
//                                                              overflow: TextOverflow.ellipsis,
//                                                              maxLines: 1,
//                                                              style: TextStyle(
//                                                                fontWeight: FontWeight.w600,
//                                                              ),
//                                                            ),
//                                                          ],
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                              Expanded(
//                                                child: Row(
//                                                  children: <Widget>[
//                                                    Expanded(
//                                                      child: Column(
//                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                                        children: <Widget>[
//                                                          Text(
//                                                            'Date',
//                                                            style: TextStyle(color: Colors.black.withOpacity(0.5)),
//                                                          ),
//                                                          Text(
//                                                            '4th Nov,2019 ',
//                                                            style: TextStyle(fontWeight: FontWeight.w600),
//                                                          ),
//                                                        ],
//                                                      ),
//                                                    ),
//                                                    Expanded(
//                                                      child: Column(
//                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                                        children: <Widget>[
//                                                          Text(
//                                                            'ID Number',
//                                                            style: TextStyle(color: Colors.black.withOpacity(0.5)),
//                                                          ),
//                                                          Text(
//                                                            '2484081530',
//                                                            style: TextStyle(fontWeight: FontWeight.w600),
//                                                          ),
//                                                        ],
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
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
