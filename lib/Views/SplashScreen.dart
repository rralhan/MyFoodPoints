import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
