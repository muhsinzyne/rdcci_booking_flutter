import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/models/validate_booking_id.dart';
import 'package:rdcciappointment/screens/booking/branch_selection.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class VerifyUserScreen extends StatefulWidget {
  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  bool validatingId = false;
  AppointmentServices appointmentServices = AppointmentServices();
  ValidateBookingID validateBookingID;
  String bookingDate = '';
  String bookingSlot = '';
  bool hasBooking = false;
  var dateFormatter = new DateFormat.yMMMMd('en_US');
  var timeFormat = DateFormat('Hm');

  void _continueService() async {
    if (this._formKey.currentState.validate()) {
      setState(() {
        validatingId = true;
      });
      validateBookingID = await appointmentServices.validateBookingId(idNumberInput.text);
      if (validateBookingID.id != null) {
        setState(() {
          hasBooking = true;
          var parsedDate = DateTime.parse(validateBookingID.bookingDate);
          bookingDate = dateFormatter.format(parsedDate);
          bookingSlot = timeFormat.format(parsedDate);
        });
      } else {
        setState(() {
          hasBooking = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BranchSelectionScreen(
              nationalId: idNumberInput.text,
              visitorName: (" ${firstName.text} ${secondName.text} ${lastName.text}"),
              visitorEmail: email.text,
            ),
          ),
        );
      }
      setState(() {
        validatingId = false;
      });
      return;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final idNumberInput = TextEditingController();
  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();

  String nationalIdValidator(String value) {
    Pattern pattern = r'^(1|2)([0-9]{9})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return getTranslate(context, 'enter_valid_national_id_or_iqama');
    else
      return null;
  }

  void formValidate() {
    setState(() {
      this._formKey.currentState.validate();
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return getTranslate(context, 'enter_valid_email');
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslate(context, 'verify_identity')),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: AutoSizeText(
                      getTranslate(context, 'user_verification'),
                      minFontSize: 22,
                      maxFontSize: 26,
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: idNumberInput,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'national_id_or_iqama'),
                    contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    //formValidate();
                  },
                  validator: nationalIdValidator,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: firstName,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'first_name'),
                    contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {},
                  validator: (value) => value.isEmpty ? getTranslate(context, 'filed_can_not_be_blank') : null,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: secondName,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'second_name'),
                    contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value.isEmpty ? getTranslate(context, 'filed_can_not_be_blank') : null,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: lastName,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'last_name'),
                    contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    //formValidate();
                  },
                  validator: (value) => value.isEmpty ? getTranslate(context, 'filed_can_not_be_blank') : null,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'email'),
                    contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    //formValidate();
                  },
                  validator: validateEmail,
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: hasBooking
                    ? Container(
                        margin: EdgeInsets.only(top: 50),
                        width: double.maxFinite,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              getTranslate(context, 'you_have_an_existing_booking_for'),
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            AutoSizeText(
                              "$bookingDate " + getTranslate(context, 'at') + " $bookingSlot",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
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
                      onPressed: _continueService,
                      color: Theme.of(context).primaryColor,
                      child: validatingId
                          ? footerButtonLoading()
                          : AutoSizeText(
                              getTranslate(context, 'continue'),
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

  Widget footerButtonLoading() {
    return SpinKitWave(
      color: Colors.white,
      type: SpinKitWaveType.start,
      size: 30,
    );
  }
}
