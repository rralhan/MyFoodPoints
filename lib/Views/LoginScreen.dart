import 'package:flutter/material.dart';
import 'package:myfoodpoints/Business/MyAuthentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Image.asset("images/KB.png"),
            SizedBox(height: 50.0),
            RaisedButton(
                child: Text('Sign in with Google'),
                onPressed: () => onClickGoogleSignIn(context),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            SizedBox(height: 15.0),
            RaisedButton(
                child: Text("Sign up with Email"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () => Navigator.pushNamed(context,
                    '/registerUser'), //Navigator.of(context).pushReplacementNamed('/registerUser'),
                color: Colors.white),
            FlatButton(
                child: Text("Sign in with Email",
                    style: TextStyle(
                        color: Colors.blue[50],
                        decoration: TextDecoration.underline),
                    textDirection: TextDirection.ltr),
                onPressed: () => Navigator.pushNamed(context, '/loginUser'))
          ],
        ),
      ),
    );
  }

  onClickGoogleSignIn(BuildContext context) async {
    var myAuth = new MyAuthentication();

    var myUser = await myAuth.signInWithGoogle();
    if (myUser != null) {
      var authId = await myUser.getIdToken();
      //if user doesn't exist add to firebase else update signin time and uuid.
      /*  UsersDAL userFSDAL = new UsersDAL();
      var dbUser = await userFSDAL.getUserByEmail(myUser.email);
      if (dbUser == null) {
        dbUser = new User();
        dbUser.authId = authId;
        dbUser.displayText = myUser.displayName;
        dbUser.email = myUser.email;

        dbUser.signedIn = DateTime.now().toUtc();
        dbUser.isActive = true;
        dbUser.metaData = "GoogleSignIn";
        userFSDAL.addUser(dbUser);

//add to userDevice

      } else {
        if (dbUser.authId != authId) {
          dbUser.authId = authId;
        }
        dbUser.signedIn = DateTime.now().toUtc();
        userFSDAL.updateUser(dbUser);
      } */
      if (authId != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("dbUserId", authId.token);
      }
      Navigator.of(context).pushReplacementNamed('/homeScreen');
    }
  }
}
