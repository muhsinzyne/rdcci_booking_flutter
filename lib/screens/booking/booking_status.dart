import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ticket_pass_package/ticket_pass.dart';

class BookingStatus extends StatefulWidget {
  final int bookingID;
  final String qrCodeLink;

  const BookingStatus({Key key, this.bookingID, this.qrCodeLink}) : super(key: key);
  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  Future<void> _cancelBooking() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure to cancel this booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Once you are canceled the booking. It would not able to revert back.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Booking Status'),
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
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: TicketPass(
                                alignment: Alignment.center,
                                animationDuration: Duration(milliseconds: 200),
                                separatorColor: Colors.black,
                                separatorHeight: 2.0,
                                color: Colors.white,
                                curve: Curves.easeOut,
                                expandIcon: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                  size: 0,
                                ),
                                titleColor: Colors.white,
                                ticketTitle: Text(
                                  '',
                                ),
                                titleHeight: 0,
                                width: 350,
                                height: 420,
                                shadowColor: Colors.white.withOpacity(0.5),
                                elevation: 8,
                                shouldExpand: false,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            width: 220,
                                            height: 220,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage('https://chart.googleapis.com/chart?chs=500x500&cht=qr&chl=234444434443&choe=UTF-8'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 160,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              'Appointment Time',
                                                              style: TextStyle(color: Colors.black.withOpacity(0.5)),
                                                            ),
                                                            Text(
                                                              '12:00 PM',
                                                              style: TextStyle(fontWeight: FontWeight.w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                color: Colors.black.withOpacity(0.5),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Muhammed Muhisn',
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            'Date',
                                                            style: TextStyle(color: Colors.black.withOpacity(0.5)),
                                                          ),
                                                          Text(
                                                            '4th Nov,2019 ',
                                                            style: TextStyle(fontWeight: FontWeight.w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            'ID Number',
                                                            style: TextStyle(color: Colors.black.withOpacity(0.5)),
                                                          ),
                                                          Text(
                                                            '2484081530',
                                                            style: TextStyle(fontWeight: FontWeight.w600),
                                                          ),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                        'Cancel  Appointment',
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
