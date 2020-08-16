import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/main.dart';
import 'package:rdcciappointment/models/branch.dart';
import 'package:rdcciappointment/models/branchListResponse.dart';
import 'package:rdcciappointment/screens/booking/select_service.dart';
import 'package:rdcciappointment/screens/components/loading_screen.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class BranchSelectionScreen extends StatefulWidget {
  @override
  _BranchSelectionScreenState createState() => _BranchSelectionScreenState();
}

class _BranchSelectionScreenState extends State<BranchSelectionScreen> {
  String currentLanguage = 'en';
  AppointmentServices appointmentServices = new AppointmentServices();
  BranchListResponse branchListResponse;
  bool pageReady = false;
  @override
  void initState() {
    super.initState();
    this._loadClient();
  }

  void _loadClient() async {
    currentLanguage = MyApp.getCurrentLocal(context);
    await Future.delayed(Duration(milliseconds: 400));
    BranchListResponse response = await appointmentServices.getBranch();
    setState(() {
      branchListResponse = response;
      pageReady = true;
    });
  }

  final List<dynamic> department = [
    {"name": "Al Malaz Branch", "image": 'asset/images/computer.png', "address": "Salah El Din Street, Al Malaz"},
    {"name": "National Products Branch", "image": 'asset/images/computer.png', "address": "King Abdullah Road, National Products Center"},
    {"name": "Ministry of Commerce & Investment	", "image": 'asset/images/computer.png', "address": "Ministry of Commerce & Investment, Exit 6"},
    {"name": "Riyadh Traffic Branch	", "image": 'asset/images/computer.png', "address": "Al Nasiriya"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(getTranslate(context, 'select_branch')),
      ),
      body: pageReady
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final Branch cBranch = this.branchListResponse.data[index];
                print(cBranch);
                final cItem = department[index];
                //print(cItem);
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      title: AutoSizeText(
                        (currentLanguage == 'en') ? cBranch.branchNameEnglish : cBranch.branchNameArabic,
                        minFontSize: 16,
                        maxFontSize: 22,
                      ),
                      subtitle: AutoSizeText(
                        (currentLanguage == 'en') ? cBranch.addressEnglish : cBranch.addressArabic,
                        minFontSize: 12,
                        maxFontSize: 16,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceSelectScreen(
                              branchId: cBranch.id,
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: this.branchListResponse?.data?.length ?? 0,
            )
          : LoadingScreenContent(),
    );
  }
}
