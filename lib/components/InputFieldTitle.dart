import 'package:flutter/material.dart';

class InputFieldTitle extends StatelessWidget {

  InputFieldTitle({@required this.title});

    final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(2.0,0.0,0.0,0.0),
      child: Text(
          title,
          textAlign: TextAlign.start,
          style:TextStyle(
            fontFamily: 'Poppins',
            color: Color.fromRGBO(124, 129, 146, 1.0),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          )
      ),
    );
  }
}