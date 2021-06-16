import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tredbook/components.dart';
import 'package:tredbook/firebaseService.dart';
import 'package:tredbook/screens/phone_auth_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset("assets/images/main_top.png",
                      width: size.width * .3),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset("assets/images/main_bottom.png",
                      width: size.width * .4),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/appstore.png",
                          width: size.width * .4),
                      SizedBox(height: 20.0),
                      Text(
                        "Login with :",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            RoundedButton(
                              text: "Phone Number",
                              iconData: FontAwesomeIcons.phone,
                              color: Colors.teal,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PhoneAuthScreen.id);
                              },
                            ),
                            SizedBox(height: 10.0),
                            RoundedButton(
                              text: "Google Account",
                              iconData: FontAwesomeIcons.google,
                              color: Colors.amber,
                              onPressed: () {
                                FirebaseService().googleSignIn(context);
                              },
                            ),
                            SizedBox(height: 10.0),
                            RoundedButton(
                              text: "Apple Account",
                              iconData: FontAwesomeIcons.apple,
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
