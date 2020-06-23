import 'package:flutter/material.dart';
import 'package:ticket_pass_package/ticket_pass.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Booking Status'),
        //elevation: 0,
      ),
      body: Center(
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
          ],
        ),
      ),
    );
  }
}
