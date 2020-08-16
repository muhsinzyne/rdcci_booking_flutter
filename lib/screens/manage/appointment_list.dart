import 'package:flutter/material.dart';
import 'package:rdcciappointment/screens/booking/booking_status.dart';
import 'package:rdcciappointment/screens/components/ticket_pass_list_item.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  void _bookingStatus() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingStatus(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment List'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: _bookingStatus,
                  child: TicketPassListItem(
                    statusType: 'cancelled',
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
