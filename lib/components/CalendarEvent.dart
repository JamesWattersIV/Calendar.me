import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarEvent extends StatelessWidget {

  CalendarEvent({@required this.time, @required this.eventName});

    final String time;
    final String eventName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0,2.0,0.0,4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 70.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Expanded(
                    child: Container(
                      child: Icon(Icons.access_time,
                          color:
                          Color.fromRGBO(124, 129, 146, 1.0)),
                    )),
                Text('$time',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color:
                      Color.fromRGBO(124, 129, 146, 1.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ))
              ]),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '$eventName',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Icon(Icons.arrow_forward_ios,
                    color:
                    Color.fromRGBO(124, 129, 146, 1.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}