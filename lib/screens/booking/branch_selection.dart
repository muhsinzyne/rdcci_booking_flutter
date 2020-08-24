import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/main.dart';
import 'package:rdcciappointment/models/branch.dart';
import 'package:rdcciappointment/models/branchListResponse.dart';
import 'package:rdcciappointment/providers/global_provider.dart';
import 'package:rdcciappointment/screens/booking/select_service.dart';
import 'package:rdcciappointment/screens/components/loading_screen.dart';
import 'package:rdcciappointment/services/appointment_service.dart';

class BranchSelectionScreen extends StatefulWidget {
  final String nationalId;
  final String visitorName;
  final String visitorEmail;

  const BranchSelectionScreen({Key key, this.nationalId, this.visitorName, this.visitorEmail}) : super(key: key);
  @override
  _BranchSelectionScreenState createState() => _BranchSelectionScreenState();
}

class _BranchSelectionScreenState extends State<BranchSelectionScreen> {
  GlobalProvider _globalProvider;

  String currentLanguage = 'en';
  AppointmentServices appointmentServices = new AppointmentServices();
  BranchListResponse branchListResponse;
  bool pageReady = false;
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
    await Future.delayed(Duration(milliseconds: 400));
    BranchListResponse response = await appointmentServices.getBranch();
    setState(() {
      branchListResponse = response;
      pageReady = true;
    });
  }

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
                        _globalProvider.selectedBranch = cBranch;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceSelectScreen(
                              branchId: cBranch.id,
                              visitorEmail: this.widget.visitorEmail,
                              visitorName: this.widget.visitorName,
                              nationalId: this.widget.nationalId,
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
