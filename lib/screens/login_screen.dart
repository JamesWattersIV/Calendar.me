import 'package:flutter/material.dart';
import 'package:calendarapp/components/RoundedButton.dart';
import 'package:calendarapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calendarapp/screens/calendar_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:calendarapp/components/InputFieldTitle.dart';
import 'package:calendarapp/services/error_handle.dart';

class LoginScreen extends StatefulWidget {

  static const String id= 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  ErrorHandler errorMessage = new ErrorHandler();

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
                    height: 100.0,
                  ),
                  Hero(
                    tag:'titleText',
                    child:  Material(
                      type: MaterialType.transparency,
                      child: Text(
                        'Login',
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
                  SizedBox(
                    height:50.0
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
                  SizedBox(
                    height: 48.0,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFieldTitle(
                          title:'Email'
                        ),
                        TextField(
                          style: kInputTextStyle,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            //Do something with the user input.
                            email = value;
                          },
                          decoration: kFieldDecoration.copyWith(hintText: ' '),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
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
                    height: 24.0,
                  ),
                  RoundedButton(
                  title: 'LOGIN',
                    colour: Color.fromRGBO(44, 152, 240, 1.0),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if(newUser != null){
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        errorMessage.handleError(e.code,context);
                        print(e);
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
