import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/main.dart';
import 'package:rdcciappointment/screens/booking/department_selection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Locale current = Locale('en', 'US');

  void _bookAnAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepartmentSelectionScreen(),
      ),
    );
  }

  void languageSwitch() {
    Locale _ar = Locale('ar', 'SA');
    Locale _en = Locale('en', 'US');
    if (current.countryCode == 'US') {
      current = _ar;
    } else {
      current = _en;
    }
    MyApp.setLocale(context, current);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/images/wall_paper.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.green,
                          ),
                          child: InkWell(
                            onTap: languageSwitch,
                            child: Center(
                              child: AutoSizeText(
                                current.countryCode == 'US' ? 'ع' : 'En',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(.6),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: FlatButton(
                                onPressed: _bookAnAppointment,
                                color: Colors.blue,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  child: AutoSizeText(
                                    getTranslate(context, 'manage'),
                                    minFontSize: 8,
                                    maxFontSize: 12,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: FlatButton(
                                onPressed: _bookAnAppointment,
                                color: Colors.green,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  child: AutoSizeText(
                                    getTranslate(context, 'appointment'),
                                    minFontSize: 8,
                                    maxFontSize: 12,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: AutoSizeText(
                                  getTranslate(context, 'powered_by'),
                                  textAlign: TextAlign.center,
                                  minFontSize: 14,
                                  maxFontSize: 16,
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
