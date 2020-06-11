import 'package:flutter/material.dart';

class ErrorHandler {

  void handleError(String errorCode, BuildContext context){
    switch (errorCode){
      case "ERROR_EMAIL_ALREADY_IN_USE":
        promptAlert('Registration Error','This Email Is Already Registered',context);
        break;
      case "ERROR_USER_DISABLED":
        promptAlert('Login Error','Your Account Has Been Disabled',context);
        break;
      case "ERROR_USER_NOT_FOUND":
        promptAlert('Login Error','No Account Could Be Found',context);
        break;
      case "ERROR_USER_TOKEN_EXPIRED":
        promptAlert('Login Error','Unable To Log User In',context);
        break;
      case "ERROR_WRONG_PASSWORD":
        promptAlert('Login Error','Email/Password Is Incorrect',context);
        break;
      case "ERROR_INVALID_EMAIL":
        promptAlert('Login Error','Email Is Incorrect',context);
        break;
      default :
        promptAlert('App Error','Unable To Process Request',context);
    }
  }

  void promptAlert(String title, String message, BuildContext context){
    showDialog(context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("$title",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  letterSpacing: 1.0,
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                )),
            content: new Text("$message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  letterSpacing: 1.0,
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                color: Color.fromRGBO(44, 152, 240, 1.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("OK",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        letterSpacing: 1.0,
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

}