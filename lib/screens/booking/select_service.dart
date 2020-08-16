import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/main.dart';
import 'package:rdcciappointment/models/services/serviceCategory.dart';
import 'package:rdcciappointment/models/services/serviceListBranch.dart';
import 'package:rdcciappointment/models/services/services.dart';
import 'package:rdcciappointment/screens/booking/booking_screen.dart';
import 'package:rdcciappointment/screens/components/loading_screen.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class ServiceSelectScreen extends StatefulWidget {
  final num branchId;

  const ServiceSelectScreen({Key key, this.branchId}) : super(key: key);
  @override
  _ServiceSelectScreenState createState() => _ServiceSelectScreenState();
}

class _ServiceSelectScreenState extends State<ServiceSelectScreen> {
  ServiceListBranch serviceListBranch;

  String currentLanguage = 'en';
  bool pageReady = false;

  List<dynamic> selectedServiceList = [];

  @override
  void initState() {
    this.setValue();
    super.initState();
    this._loadClient();
  }

  void _loadClient() async {
    currentLanguage = MyApp.getCurrentLocal(context);
    await Future.delayed(Duration(milliseconds: 400));
    AppointmentServices appointmentServices = new AppointmentServices();
    if (this.widget.branchId != null) {
      print(this.widget.branchId);
      ServiceListBranch response = await appointmentServices.getBranchServices(id: this.widget.branchId);
      print(response.toJson());
      setState(() {
        serviceListBranch = response;
        pageReady = true;
      });
    } else {}
  }

  void setValue() {}
  void _continueService() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(
          selectedBranch: this.widget.branchId,
        ),
      ),
    );
  }

  void _selectThisService(Services service) {
    if (service.selected == true) {
      // un tick fire
      setState(() {
        service.selected = !service.selected;
        selectedServiceList.removeWhere((item) => item.id == service.id);
      });
    } else if (selectedServiceList.length < 2 && service.selected == false) {
      setState(() {
        service.selected = !service.selected;
      });
      selectedServiceList.add(service);
    } else {
      maximumAlert();
    }

    print(selectedServiceList);
  }

  void _selectThisOtherService(Services service) {
    if (service.selected == false) {
      if (selectedServiceList.length < 2) {
        setState(() {
          service.selected = !service.selected;
          service.isOtherActivated = true;
          selectedServiceList.add(service);
        });
      } else {
        maximumAlert();
        // maximum reached
      }
    } else if (service.selected == true) {
      selectedServiceList.removeWhere((item) => item.id == service.id);
      setState(() {
        service.selected = !service.selected;
        service.isOtherActivated = false;
      });
    }
  }

  void maximumAlert() {
    Fluttertoast.showToast(
      msg: "Maximum selectable service is limited to 2",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void toastError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void otherValueChangeSet(Services service, String value) {
    service.otherValue = value;
    Services itemFromList = selectedServiceList.firstWhere((element) => element.id == service.id);
    setState(() {
      validToContinue();
    });
  }

  bool validToContinue() {
    bool response = true;
    if (selectedServiceList.length < 1) {
      // no service selected error

      response = false;
    } else {
      selectedServiceList.forEach((selectedService) {
        if (selectedService.isOtherActivated == true && selectedService.otherValue == '') {
          response = false;
        }
      });

      if (response == false) {
        // enter a value for the other service
      }
    }
    return response;
  }

  void continueError() {
    bool response = true;
    if (selectedServiceList.length < 1) {
      toastError(getTranslate(context, 'please_select_at_least_one_service'));
    } else {
      selectedServiceList.forEach((selectedService) {
        if (selectedService.isOtherActivated == true && selectedService.otherValue == '') {
          response = false;
        }
      });

      if (response == false) {
        toastError(getTranslate(context, 'other_service_name_should_not_be_empty'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslate(context, 'select_services')),
      ),
      body: pageReady == false
          ? LoadingScreenContent()
          : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final ServiceCategory cServiceCat = this.serviceListBranch.serviceCategory[index];
                      //print(cServiceCat.);
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                    child: AutoSizeText(
                                      (currentLanguage == 'en') ? cServiceCat.categoryNameEnglish : cServiceCat.categoryNameArabic,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width / 19.5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                      maxFontSize: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int serviceIndex) {
                                  final Services cService = cServiceCat.services[serviceIndex];
                                  //print(cService.toJson());
                                  if (cService.isOther == 1) {
                                    return Column(
                                      children: <Widget>[
                                        ListTile(
                                          onTap: () {
                                            _selectThisOtherService(cService);
                                          },
                                          leading: Icon(
                                            Icons.info,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          title: Text((currentLanguage == 'en') ? cService.serviceNameEnglish : cService.serviceNameArabic),
                                          trailing: Checkbox(
                                            value: cService.selected,
                                            onChanged: (bool value) {
                                              _selectThisOtherService(cService);
                                            },
                                          ),
                                        ),
                                        cService.isOtherActivated == true
                                            ? Container(
                                                margin: EdgeInsets.only(left: 30, right: 30),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: getTranslate(context, 'service_name'),
                                                    contentPadding: EdgeInsets.only(bottom: -1, top: -5, left: 10),
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (value) {
                                                    otherValueChangeSet(cService, value);
                                                  },
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    );
                                  } else {
                                    return ListTile(
                                      onTap: () {
                                        _selectThisService(cService);
                                      },
                                      leading: Icon(
                                        Icons.info,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      title: Text((currentLanguage == 'en') ? cService.serviceNameEnglish : cService.serviceNameArabic),
                                      trailing: Checkbox(
                                        value: cService.selected,
                                        onChanged: (bool value) {
                                          _selectThisService(cService);
                                        },
                                      ),
                                    );
                                  }
                                },
                                itemCount: cServiceCat.services.length)
                          ],
                        ),
                      );
                    },
                    itemCount: this.serviceListBranch?.serviceCategory?.length ?? 0),
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
                      onPressed: validToContinue() ? _continueService : continueError,
                      color: (validToContinue() ? Theme.of(context).primaryColor : Colors.grey),
                      child: AutoSizeText(
                        'Continue',
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
