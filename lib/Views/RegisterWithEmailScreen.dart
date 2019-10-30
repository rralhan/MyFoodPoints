import 'package:flutter/material.dart';
import 'package:myfoodpoints/Business/MyAuthentication.dart';
import 'package:myfoodpoints/DataAccess/FireStore/UsersDAL.dart';
import 'package:myfoodpoints/Helpers/FormUtility.dart';
import 'package:myfoodpoints/Models/User.dart';
import 'package:myfoodpoints/Models/UserProfile.dart';
import 'package:myfoodpoints/Models/ViewModels/UserRegistrationVM.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterWithEmailScreen extends StatefulWidget {
  RegisterWithEmailScreen({Key key}) : super(key: key);

  @override
  _RegisterWithEmailScreenState createState() => _RegisterWithEmailScreenState();
}

class _RegisterWithEmailScreenState extends State<RegisterWithEmailScreen> with FormUtility {
   final _formKey = GlobalKey<FormState>();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _pwdFocus = FocusNode();
  final FocusNode _cnfmPwdFocus = FocusNode();
  var _emailController = new TextEditingController();
  var _pwdController = new TextEditingController();
  UserRegistrationVM userRgVM = new UserRegistrationVM();
  String _userCheckResult;

  @override
  Widget build(BuildContext context) {
    userRgVM = new UserRegistrationVM();

    final firstName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLength: 25,
      textInputAction: TextInputAction.next,
      focusNode: _firstNameFocus,
      onFieldSubmitted: (term) {
        fieldFocusChange(context, _firstNameFocus, _lastNameFocus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your first name';
        }
        if (value.length < 3) {
          return 'First Name must be more than 2 characters';
        }
      },
      onSaved: (val) => userRgVM.firstName = val,
      decoration: getTextFormDecoration('First Name'),
    );

    final lastName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLength: 25,
      textInputAction: TextInputAction.next,
      focusNode: _lastNameFocus,
      onFieldSubmitted: (term) {
        fieldFocusChange(context, _lastNameFocus, _emailFocus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your last name';
        }
        if (value.length < 3) {
          return 'Last Name must be more than 2 characters';
        }
        return null;
      },
      onSaved: (val) => userRgVM.lastName = val,
      decoration: getTextFormDecoration('Last Name'),
    );

    final email = TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        autofocus: false,
        maxLength: 50,
        textInputAction: TextInputAction.next,
        focusNode: _emailFocus,
        onFieldSubmitted: (term) {
          fieldFocusChange(context, _emailFocus, _pwdFocus);
        },
        onSaved: (val) => userRgVM.email = val,
        validator: (value) {
          String retval;
          if (value.isEmpty) {
            retval = 'Please enter an Email Address';
          } else {
            retval = emailPatternValidation(value);
            if (retval == null) {
              retval = _userCheckResult;
            }
          }

          return retval;
        },
        decoration: getTextFormDecoration('Email'));

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _pwdController,
      maxLength: 25,
      textInputAction: TextInputAction.next,
      focusNode: _pwdFocus,
      onFieldSubmitted: (term) {
        fieldFocusChange(context, _pwdFocus, _cnfmPwdFocus);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a password';
        }
        return passwordPatternValidation(value);
      },
      onSaved: (val) => userRgVM.password = val,
      decoration: getTextFormDecoration('Password'),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      maxLength: 25,
      textInputAction: TextInputAction.done,
      focusNode: _cnfmPwdFocus,
      onFieldSubmitted: (val) {
        onCreateNewUser(context);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please confirm your password';
        }
        return confirmPasswordValidation(value, _pwdController.text);
      },
      decoration: getTextFormDecoration('Confirm Password'),
    );

    final signupButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () => onCreateNewUser(context),
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      child: Text('Sign Up', style: TextStyle(color: Colors.white)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration'),
      ),
      body: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(30.0),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: 30.0,
                                bottom: 5.0,
                                left: 10.0,
                                right: 10.0),
                            child: firstName),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: lastName),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: email),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: password),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            child: confirmPassword),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            child: signupButton),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Already have an account? Sign in.",
                                      style: TextStyle(fontSize: 15.0),
                                    )),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  InputDecoration getTextFormDecoration(String labelText) {
    var decoration = InputDecoration(
        labelText: labelText,
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        errorMaxLines: 10);
    return decoration;
  }

  Future<String> checkForUserExistence(email) async {
    var userDAL = new UsersDAL();
    var exists = await userDAL.doesUserExist(email);
    if (exists) return "This email address already exists in our system.";
    return null;
  }

  Future onCreateNewUser(BuildContext context) async {
    String tUserExistence = await checkForUserExistence(_emailController.text);
    setState(() {
      _userCheckResult = tUserExistence;
    });

    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      var myAuth = new MyAuthentication();
      var myUser =
          await myAuth.signUpWithEmail(userRgVM.email, userRgVM.password);
      if (myUser != null) {
        var authId = await myUser.getIdToken();
        //if user doesn't exist add to firebase else update signin time and uuid.
        UsersDAL userFSDAL = new UsersDAL();
        var dbUser = await userFSDAL.getUserByEmail(myUser.email);
        if (dbUser == null) {
          dbUser = new User();
          dbUser.token = authId.token;
          dbUser.name = "$userRgVM.firstName $userRgVM.lastName";
          dbUser.email = myUser.email;
          dbUser.signedIn = DateTime.now().toUtc();
          dbUser.isActive = true;
          dbUser.metaData = "emailAndpassword";


          var userProfile = new UserProfile();
          userProfile.firstName = userRgVM.firstName;
          userProfile.lastName = userRgVM.lastName;
          dbUser.userProfile = userProfile;

          userFSDAL.addUser(dbUser);

          //add to userDevice
        }
        if (dbUser != null) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("dbUserId", dbUser.id);
        }
        Navigator.of(context).pushReplacementNamed('/homeScreen');
      }
    }
  }
}