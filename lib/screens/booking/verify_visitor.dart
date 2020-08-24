import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/screens/booking/branch_selection.dart';

class VerifyUserScreen extends StatefulWidget {
  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  void _continueService() {
    if (this._formKey.currentState.validate()) {
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
                      child: AutoSizeText(
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
}
