import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kFieldDecoration = InputDecoration(
  fillColor: Color.fromRGBO(255, 255, 255, 0.2) ,
  hintText: 'Enter A Value',
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent
    ),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(1.0)),
      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1))),
    filled: true,
);

const kInputTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

const kRotatingTextStyle = TextStyle(
    color:Colors.white,
fontFamily: 'Poppins',
fontSize: 30.0,
fontWeight: FontWeight.w400);
