import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/models/booking_confirm/bookingResponse.dart';
import 'package:rdcciappointment/screens/manage/appointment_status.dart';
import 'package:rdcciappointment/screens/styles/general.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class VerifyIdentity extends StatefulWidget {
  @override
  _VerifyIdentityState createState() => _VerifyIdentityState();
}

class _VerifyIdentityState extends State<VerifyIdentity> {
  var idNumberInput = TextEditingController();
  var emailInput = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

  AppointmentServices appointmentServices = new AppointmentServices();

  String nationalIdValidator(String value) {
    Pattern pattern = r'^(1|2)([0-9]{9})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return getTranslate(context, 'enter_valid_national_id_or_iqama');
    else
      return null;
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

  void checkAppointment() async {
    if (this._formKey2.currentState.validate()) {
      BookingResponse response = await appointmentServices.getBookingResponse(this.idNumberInput.text, this.emailInput.text);
      if (response.statusCode == 200) {
        print(response.data.toJson());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentStatusDetail(bookingData: response.data),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: getTranslate(context, 'you_dont_have_any_booking_with_this_national_id_and_email'),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
      //   BookingResponse response =
    } else {
      Fluttertoast.showToast(
        msg: getTranslate(context, 'please_fill_the_required_information'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslate(context, 'manage')),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey2,
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: idNumberInput,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'national_id_or_iqama'),
                    contentPadding: kInputContentPadding,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    //formValidate();
                  },
                  validator: nationalIdValidator,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: TextFormField(
                  controller: emailInput,
                  decoration: InputDecoration(
                    labelText: getTranslate(context, 'email'),
                    contentPadding: kInputContentPadding,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    //formValidate();
                  },
                  validator: validateEmail,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton(
//                shape: new RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(30.0),
//                ),
                  onPressed: checkAppointment,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    getTranslate(context, 'check_appointment'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
