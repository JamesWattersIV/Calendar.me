import 'package:flutter/material.dart';
import 'package:calendarapp/components/CalendarEvent.dart';

class EventTile extends StatelessWidget {
  final String eventTitle;
  final String eventTime;
  final String eventDate;
  final Function checkboxCallback;
  final Function longpressCallback;

  EventTile({this.eventTitle, this.eventDate,this.eventTime, this.checkboxCallback,this.longpressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onLongPress: longpressCallback,
        title: CalendarEvent(
            time: eventTime, eventName: eventTitle,eventDate:eventDate)
    );
  }
}
