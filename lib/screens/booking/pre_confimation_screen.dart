import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rdcciappointment/providers/global_provider.dart';
import 'package:rdcciappointment/screens/animations/ui_animations.dart';
import 'package:rdcciappointment/screens/booking/booking_status.dart';

class PreConfirmationScreen extends StatefulWidget {
  @override
  _PreConfirmationScreenState createState() => _PreConfirmationScreenState();
}

class _PreConfirmationScreenState extends State<PreConfirmationScreen> {
  GlobalProvider _globalProvider;
  @override
  void didChangeDependencies() {
    _globalProvider = Provider.of<GlobalProvider>(context, listen: true);
    super.didChangeDependencies();
  }

  void _bookNow() async {
    _globalProvider.loader = true;
    await Future.delayed(Duration(seconds: 3));
    _globalProvider.loader = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BookingStatus(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _globalProvider.loader,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Confirm Appointment'),
          elevation: 0,
        ),
        body: getPageContents(),
      ),
      progressIndicator: PageLoadingAnimation(
        style: LoadingAnimationStyle.style1,
        size: 60,
      ),
    );
  }

  Widget getPageContents() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'asset/images/speaking.png',
                  fit: BoxFit.contain,
                ),
                radius: 80,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  height: 60,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: AutoSizeText(
                              'Chamber for IT',
                              textAlign: TextAlign.center,
                              minFontSize: 18,
                              maxFontSize: 24,
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  CListItem(
                    label: 'ID No',
                    value: '2484081530',
                  ),
                  Divider(),
                  CListItem(
                    label: 'Name',
                    value: 'Muhammed Muhsin',
                  ),
                  Divider(),
                  CListItem(
                    label: 'Appointment Date',
                    value: 'Sep 10 2020',
                  ),
                  Divider(),
                  CListItem(
                    label: 'Time Slot',
                    value: '10 AM',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                      color: Colors.green,
                      onPressed: _bookNow,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: AutoSizeText(
                                'Book Now',
                                textAlign: TextAlign.center,
                                minFontSize: 20,
                                maxFontSize: 28,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/botton_crop.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CListItem extends StatelessWidget {
  const CListItem({
    Key key,
    this.label = '',
    this.value = '',
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: AutoSizeText(
              label,
              minFontSize: 12,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(
              value,
              minFontSize: 12,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
