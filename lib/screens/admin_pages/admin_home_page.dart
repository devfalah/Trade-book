import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  static const routeName = "adminHomePage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home Page"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
    );
  }
}
