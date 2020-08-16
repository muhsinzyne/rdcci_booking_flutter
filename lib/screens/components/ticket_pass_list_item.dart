import 'package:flutter/material.dart';
import 'package:ticket_pass_package/ticket_pass.dart';

const String UPCOMING = 'upcoming';
const String CANCELLED = 'cancelled';
const String EXPIRED = 'expired';

class TicketPassListItem extends StatelessWidget {
  final String statusType;

  const TicketPassListItem({Key key, this.statusType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TicketPass(
          shouldExpand: false,
          elevation: 8,
          width: 350,
          height: 180,
          titleHeight: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: Container(
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
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            transform: new Matrix4.rotationZ(0.174533),
            width: 100,
            height: 40,
            color: _loadStatusColor(this.statusType),
            child: Center(
                child: Text(
              this.statusType,
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  Color _loadStatusColor(String _statusType) {
    switch (_statusType) {
      case UPCOMING:
        return Colors.green;
        break;
      case CANCELLED:
        return Colors.red;
        break;
      case EXPIRED:
        return Colors.orange;
        break;
      default:
        return Colors.black;
        break;
    }
  }
}
