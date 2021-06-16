import 'package:flutter/material.dart';
import 'package:tredbook/components.dart';
import 'package:tredbook/firebaseService.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({Key key, this.phoneNumber}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    FirebaseService().verifyPhone(context, widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("verifiction"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Center(
                child: Text(
                  "+964" + widget.phoneNumber,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            RoundedPinPut(),
          ],
        ),
      ),
    );
  }
}
