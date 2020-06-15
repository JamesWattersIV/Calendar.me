import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendarapp/constants.dart';
import 'package:calendarapp/constants.dart';
import 'package:provider/provider.dart';
import 'package:calendarapp/models/event_data.dart';
import 'package:calendarapp/models/Event.dart';

import 'InputFieldTitle.dart';

String newEventTitle;
String newEventTime;
String newEventDate;
DateTime eventDateTime;


void setDateandTime(){
  if(eventDateTime == null){
    eventDateTime = DateTime.now();
  }
  List<String> arrDateTime = eventDateTime.toString().split(' ');
  String tempEventDate = arrDateTime[0];
  String tempEventTime = arrDateTime[1];
  handleDate(tempEventDate);
  handleTime(tempEventTime);
}

void handleTime(String fullTime){
  List<String> arrTime = fullTime.split(':');
  newEventTime = arrTime[0]+':'+arrTime[1];
}

void handleDate(String fullDate){
  List<String> arrDate = fullDate.split('-');
  print(arrDate);
  String month;
  String day;
  switch (arrDate[1]){
    case '01':month = 'Jan';
    break;
    case "02":month ='Feb';
    break;
    case '03':month = 'Mar';
    break;
    case "04":month ='Apr';
    break;
    case '05':month = 'May';
    break;
    case "06":month ='Jun';
    break;
    case '07':month = 'Jul';
    break;
    case "09":month ='Aug';
    break;
    case '09':month = 'Sep';
    break;
    case "10":month ='Oct';
    break;
    case '11':month = 'Nov';
    break;
    case "12":month ='Dec';
    break;
  }

  switch (arrDate[2]){
    case '01':day = '1';
    break;
    case "02":day ='2';
    break;
    case '03':day = '3';
    break;
    case "04":day ='4';
    break;
    case '05':day = '5';
    break;
    case "06":day ='6';
    break;
    case '07':day = '7';
    break;
    case "09":day ='8';
    break;
    case '09':day = '9';
    break;
    default: day =arrDate[2];
    break;
  }

  newEventDate = day + ' ' + month;

}

void addNewEvent(BuildContext context, FirebaseUser user){
  Provider.of<EventData>(context, listen: false).addEvent(newEventTitle, newEventDate, newEventTime);
  Provider.of<EventData>(context, listen: false).updateFirebase(user,newEventTitle,newEventDate,newEventTime);
}

void addToFirebase(){

}

class AddEventSheet extends StatelessWidget {

  AddEventSheet(this.currentUser);
  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Add Event',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(31, 48, 83, 1.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: InputFieldTitle(title: 'Event Name'),
                ),
                TextField(
                  style: kInputTextStyle,
                  autofocus: true,
                  onChanged: (value) {
                    newEventTitle = value;
                  },
                  decoration: kFieldDecoration.copyWith(hintText: ''),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8.0),
                  child: InputFieldTitle(title: 'Date'),
                ),
                Container(
                  height: 200,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      onDateTimeChanged: (dateTime) {
                        eventDateTime = dateTime;
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    color: Color.fromRGBO(31, 48, 83, 1.0),
                    onPressed: () {
                      setDateandTime();
                      addNewEvent(context,currentUser);
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
