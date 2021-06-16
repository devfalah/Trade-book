import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tredbook/screens/admin_pages/admin_home_page.dart';

import 'package:tredbook/screens/login_screen.dart';
import 'package:tredbook/screens/phone_auth_screen.dart';
import 'package:tredbook/screens/user_profile_screen.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trade book',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomeScreen.id: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        PhoneAuthScreen.id: (_) => PhoneAuthScreen(),
        AdminHomePage.routeName: (_) => AdminHomePage(),
        UserProfileScreen.routeName: (_) => UserProfileScreen(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
