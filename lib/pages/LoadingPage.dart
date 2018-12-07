import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';

class LoadingPage extends StatelessWidget {
    
  LoadingPage({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new CircularProgressIndicator(
            backgroundColor: colorStyles['gray'],
            strokeWidth: 2.0
          ),
        ),
      ),
    );
  }
}