import 'package:calendarapp/models/task_data.dart';
import 'package:flutter/material.dart';
import 'package:calendarapp/screens/welcome_screen.dart';
import 'package:calendarapp/screens/login_screen.dart';
import 'package:calendarapp/screens/registration_screen.dart';
import 'package:calendarapp/screens/calendar_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(CalendarApp());

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id:(context) => WelcomeScreen(),
          LoginScreen.id:(context) => LoginScreen(),
          RegistrationScreen.id:(context) => RegistrationScreen(),
          ChatScreen.id:(context) => ChatScreen(),
        },
      ),
    );
  }
}
