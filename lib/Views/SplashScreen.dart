import 'package:flutter/material.dart';
import 'dart:async';

import 'package:myfoodpoints/Business/MyAuthentication.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    new Timer(const Duration(seconds: 3), () => navigate(context));
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Image.asset("images/KB.png"),
              Padding(
                padding: EdgeInsets.all(50.0),
              ),
              CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white70),
                  strokeWidth: 4.0)
            ]),
      ),
    );
  }

  Future navigate(BuildContext context) async {
    //Navigator.of(context).pushReplacementNamed('/login');
    var myAuth = new MyAuthentication();
    //checkIfAutheticated here
    var currentUser = await myAuth.getCurrentUser();
    if (currentUser == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      //already logged in
      Navigator.of(context).pushReplacementNamed('/homeScreen');
    }
  }
}
