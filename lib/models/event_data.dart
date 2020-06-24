import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:calendarapp/models/Event.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendarapp/services/date_time_handler.dart';


class EventData extends ChangeNotifier {
  List<Event> _events =[];
  List<Event> _dailyEvents = [];
  final _firestore = Firestore.instance;
  final dateTimeHandler = new DateTimeHandler();

  void createDailyList(DateTime date){
    _dailyEvents.clear();
      for(int i = 0 ;i<events.length;i++){
        if (events[i].date == dateTimeHandler.handleFullDate(date)){
          print('match found at $i');
          _dailyEvents.add(events[i]);
        }
      }
      notifyListeners();
  }

  void handleTime(String fullTime){
    List<String> arrTime = fullTime.split(':');
  }

  void setEventsList(List globalEvents){

  }

  UnmodifiableListView<Event> get events{
    return UnmodifiableListView(_events);
  }

  UnmodifiableListView<Event> get dailyEvents{
    return UnmodifiableListView(_dailyEvents);
  }

  int get eventCount{
    return _events.length;
  }

  int get eventDailyCount{
    return _dailyEvents.length;
  }

  void updateFirebase(loggedInUser,title,date,time) async{
    try {
      final user = await _firestore.collection('users').where('uid', isEqualTo: loggedInUser.uid).getDocuments();
      await _firestore.collection('users').document(user.documents[0].documentID).updateData({
        'events': FieldValue.arrayUnion([{
          'date':date,
          'time':time,
          'title':title
        }])
      });
    } catch (e) {
      print(e);
    }
  }

  void removeFromFirebase(loggedInUser,index) async{

    try {
      final user = await _firestore.collection('users').where(
          'uid', isEqualTo: loggedInUser.uid).getDocuments();
      await _firestore.collection('users').document(
          user.documents[0].documentID).updateData({'events':FieldValue.arrayRemove([{
        'date':_events[index].date,
        'time':_events[index].time,
        'title':_events[index].title
      }])});
    }
    catch (e) {
      print(e);
    }
  }

  void addEvent(String newEventTitle, String newDate, String newTime){
    final event = new Event(title:newEventTitle,date: newDate,time: newTime);
    _events.add(event);
    notifyListeners();
  }

  void updateEvent(Event event){
    event.toggleDone();
    notifyListeners();
  }

  void deleteEvent(Event event){
    _events.remove(event);
    notifyListeners();
  }

}