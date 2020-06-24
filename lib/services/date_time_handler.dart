import 'package:flutter/material.dart';

class DateTimeHandler{

  String handleFullDate(DateTime dateTime){
    List<String> arrDateTime = dateTime.toString().split(' ');
    String tempEventDate = arrDateTime[0];
    List<String> arrDate = tempEventDate.split('-');
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

    String EventDate = day + ' ' + month;
    return EventDate;

  }

}