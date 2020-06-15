import 'package:calendarapp/components/AddEventSheet.dart';
import 'package:calendarapp/models/task_data.dart';
import 'package:calendarapp/models/event_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:calendarapp/constants.dart';
import 'package:provider/provider.dart';

import 'package:calendarapp/components/CalendarEvent.dart';
import 'package:calendarapp/components/TaskTile.dart';
import 'package:calendarapp/components/EventTile.dart';
import 'package:calendarapp/components/AddBottomSheet.dart';
import 'package:calendarapp/services/firebase_manager.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class ChatScreen extends StatefulWidget {
  static const String id = 'calendar_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;
  DateTime _currentDate;
  AnimationController controller;
  bool checkedValue = true;
  String username = '';
  FireBaseManager fbManager = new FireBaseManager();
  List globalEvents;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        final tempUsername = await fbManager.getUsername(loggedInUser);
        if (tempUsername != null) {
          setState(() {
            username = tempUsername;
          });
          getFirebaseList();
        }
        print(username);
      }
    } catch (e) {
      print(e);
    }
  }

  void getFirebaseList() async {
    final user = await _firestore.collection('users').where('uid', isEqualTo: loggedInUser.uid).getDocuments();
    if( user != null){
      globalEvents = user.documents[0].data['events'];
      if(globalEvents.length != 0){
        final testEventData = Provider.of<EventData>(context, listen: false);
        for (var i = 0; i < globalEvents.length; i++) {
          testEventData.addEvent(globalEvents[i]['title'], globalEvents[i]['date'], globalEvents[i]['time']);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser(); //Add spinner for this and getting events
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return Consumer<EventData>(builder:(context,eventData,child){
      return MaterialApp(
          home: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      text: 'Today',
                    ),
                    Tab(
                      text: 'Calendar',
                    ),
                    Tab(
                      text: 'Events',
                    )
                  ],
                ),
                backgroundColor: Color.fromRGBO(31, 48, 83, 1.0),
              ),
            ),
            body: TabBarView(
              children: [
                Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Color.fromRGBO(31, 48, 83, 1.0),
                    child: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => AddBottomSheet());
                    },
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/WelcomeBG.png'),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Text("Hi $username,", style: kRotatingTextStyle),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Text("Own Your Day!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text("${taskData.taskCount} Tasks",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0))),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return TaskTile(
                                    taskTitle: taskData.tasks[index].name,
                                    isChecked: taskData.tasks[index].isDone,
                                    checkboxCallback: (checkboxState) {
                                      taskData
                                          .updateTask(taskData.tasks[index]);
                                    },
                                    longpressCallback: () {
                                      taskData
                                          .deleteTask(taskData.tasks[index]);
                                    },
                                  );
                                },
                                itemCount: taskData.taskCount,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: buildCalendarCarousel(),
                    ),
                    Expanded(
                        flex: 1,
                        child: ListView(
                          children: <Widget>[
                            CalendarEvent(
                                time: '11:00', eventName: 'Qno Meeting'),
                          ],
                        ))
                  ],
                ),
                Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Color.fromRGBO(31, 48, 83, 1.0),
                    child: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => AddEventSheet(loggedInUser));
                    },
                  ),
                  body: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0),
                        Text(
                          'Upcoming Events',
                          style: TextStyle(
                              color: Color.fromRGBO(31, 48, 83, 1.0),
                              fontFamily: 'Poppins',
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(
                            height: 20.0),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0))),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return EventTile(
                                    eventTitle: eventData.events[index].title,
                                    eventTime: eventData.events[index].time,
                                    eventDate: eventData.events[index].date,
                                    checkboxCallback: (checkboxState) {
                                      eventData
                                          .updateEvent(eventData.events[index]);
                                    },
                                    longpressCallback: () {
                                      eventData
                                          .deleteEvent(eventData.events[index]);
                                      eventData.removeFromFirebase(loggedInUser,index);
                                    },
                                  );
                                },
                                itemCount: eventData.eventCount,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
      });
    });
  }

  static Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2020, 6, 6): [
        new Event(
          date: new DateTime(2020, 6, 6),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2020, 6, 6),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 6, 6),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  CalendarCarousel<Event> buildCalendarCarousel() {
    return CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
      },
      todayBorderColor: Color.fromRGBO(31, 48, 83, 1.0),
      todayButtonColor: Color.fromRGBO(31, 48, 83, 1.0),
      iconColor: Color.fromRGBO(31, 48, 83, 1.0),
      selectedDayButtonColor: Color.fromRGBO(242, 242, 242, 1.0),
      selectedDayTextStyle: TextStyle(
          fontSize: 14.0,
          color: Color.fromRGBO(31, 48, 83, 1.0),
          fontWeight: FontWeight.w900),
      weekdayTextStyle: TextStyle(
        fontSize: 14.0,
        color: Color.fromRGBO(31, 48, 83, 1.0),
      ),
      headerTextStyle: TextStyle(
        color: Color.fromRGBO(31, 48, 83, 1.0),
        fontFamily: 'Poppins',
        fontSize: 24.0,
        fontWeight: FontWeight.w300,
      ),
      weekendTextStyle: TextStyle(
        color: Color.fromRGBO(44, 152, 240, 1.0),
      ),
      thisMonthDayBorderColor: Color.fromRGBO(31, 48, 83, 1.0),
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
      customDayBuilder: (
        /// you can provide your own build function to make custom day containers
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
        /// This way you can build custom containers for specific days only, leaving rest as default.

        //Example: every 15th of month, we have a flight, we can place an icon in the container like that:
        /*if (day.day == 15) {
                  return Center(
                    child: Icon(Icons.local_airport),
                  );
                } else {
                  return null;
                }*/
        return null;
      },
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 400.0,
      selectedDateTime: _currentDate,
      daysHaveCircularBorder: null,

      /// null for not rendering any border, true for circular border, false for rectangular border
    );
  }
}

/*onPressed: () {
                    //Implement logout functionality
                    _auth.signOut();
                    Navigator.pop(context);
                  }),*/
