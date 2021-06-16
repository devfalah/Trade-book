import 'package:flutter/material.dart';
import 'package:tredbook/components.dart';
import 'package:tredbook/screens/otp_screen.dart';

class PhoneAuthScreen extends StatelessWidget {
  static const id = "phoneAuthScreen";
  var _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number here",
                        counterText: "",
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text("+964"),
                        ),
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  text: "Verify",
                  color: Colors.teal[700],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpScreen(
                          phoneNumber: _phoneController.text,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
