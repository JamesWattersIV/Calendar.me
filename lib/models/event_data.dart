import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:calendarapp/models/Event.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';


class EventData extends ChangeNotifier {
  List<Event> _events =[];
  final _firestore = Firestore.instance;

  void setEventsList(List globalEvents){
    print(globalEvents);
  }

  UnmodifiableListView<Event> get events{
    return UnmodifiableListView(_events);
  }

  int get eventCount{
    return _events.length;
  }

  void updateFirebase(loggedInUser,title,date,time) async{
    try {
      final user = await _firestore.collection('users').where('uid', isEqualTo: loggedInUser.uid).getDocuments();
      print(user.documents[0].documentID);
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
    print(index);
    try {
      final user = await _firestore.collection('users').where('uid', isEqualTo: loggedInUser.uid).getDocuments();
      print(user.documents[0].documentID);
      await _firestore.collection('users').document(user.documents[0].documentID).updateData({
        'events': FieldValue.arrayRemove(['123456'])
      });
    } catch (e) {
      print(e);
    }
  }

  void addEvent(String newEventTitle, String newDate, String newTime){
    final event = new Event(title:newEventTitle,date: newDate,time: newTime);
    _events.add(event);
    notifyListeners();
    print(_events);
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