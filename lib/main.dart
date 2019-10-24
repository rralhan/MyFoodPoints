import 'package:flutter/material.dart';
import 'Views/HomeScreen.dart';
import 'Views/LoginScreen.dart';
import 'Views/RegisterWithEmailScreen.dart';
import 'Views/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Food Points',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.teal,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.orange.shade500,
                foregroundColor: Colors.white)),
        //home: MyHomePage(title: 'My Food Points'),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SplashScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/homeScreen': (BuildContext context) => HomeScreen(),
          '/registerUser': (BuildContext context) => RegisterWithEmailScreen(),
          /*'/loginUser': (BuildContext context) => LoginUser(),
        '/settings': (BuildContext context) => SettingsPage(),
        '/profile' : (BuildContext context) => ProfilePage(), */
        });
  }
}
