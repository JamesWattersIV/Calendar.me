import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendarapp/components/RoundedButton.dart';
import 'package:calendarapp/constants.dart';
import 'package:calendarapp/screens/calendar_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:calendarapp/components/InputFieldTitle.dart';
import 'package:calendarapp/services/error_handle.dart';
import 'package:calendarapp/services/firebase_manager.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String confirmPassword;
  String username;

  ErrorHandler errorMessage = new ErrorHandler();

  bool checkPassword(){
    if (password == confirmPassword){
      if (password.length >= 6 ){
        return true;
      } else {
        errorMessage.promptAlert('Password Error','Passwords Must Be Longer Than 6 Digits',context);
        return false;
      }
    } else {
      errorMessage.promptAlert('Password Error','Passwords Do Not Match',context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/WelcomeBG.png'),fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Hero(
                    tag:'titleText',
                    child:  Material(
                      type: MaterialType.transparency,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                        ),
                      ),
                      Hero(
                        tag:'logo',
                        child: Container(
                          height: 150.0,
                          child: Image.asset('assets/images/calendarBG.png'),
                        ),
                      ),
                    ],
                  ),
                  InputFieldTitle(
                    title: 'Username',
                  ),
                  TextField(
                    style:kInputTextStyle,
                    onChanged: (value) {
                      //Do something with the user input.
                      username = value;
                    },
                    decoration:
                        kFieldDecoration.copyWith(hintText: ''),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  InputFieldTitle(
                    title: 'Email',
                  ),
                  TextField(
                    style: kInputTextStyle,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration:
                        kFieldDecoration.copyWith(hintText: ''),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  InputFieldTitle(
                      title:'Password'
                  ),
                  TextField(
                    style: kInputTextStyle,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kFieldDecoration.copyWith(hintText: ''),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  InputFieldTitle(
                      title:'Confirm Password'
                  ),
                  TextField(
                    style: kInputTextStyle,
                    obscureText: true,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    decoration: kFieldDecoration.copyWith(hintText: ''),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'REGISTER',
                    colour: Color.fromRGBO(31, 48, 83, 1.0),
                    onPressed: () async {
                       if(checkPassword()){

                         setState(() {
                           showSpinner = true;
                         });

                         try {
                           final newUser = await _auth.createUserWithEmailAndPassword(
                               email: email, password: password);
                           if(newUser != null){
                             new FireBaseManager().createUserProfile(username);
                             Navigator.pushNamed(context, ChatScreen.id);
                           }
                           setState(() {
                             showSpinner =false;
                           });
                         } catch (e) {
                           setState(() {
                             showSpinner = false;
                           });
                           errorMessage.handleError(e.code,context);
                           print(e.code);
                         }
                       }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
