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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BranchSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslate(context, 'verify_identity')),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  labelText: getTranslate(context, 'first_name'),
                  contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: getTranslate(context, 'second_name'),
                  contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: getTranslate(context, 'last_name'),
                  contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
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
