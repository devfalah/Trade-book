import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:tredbook/appBrain.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color color;
  final Function onPressed;
  const RoundedButton({
    this.text,
    this.iconData,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        children: [
          Icon(iconData),
          Expanded(child: SizedBox()),
          Text(text),
          Expanded(child: SizedBox()),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: color == Colors.white ? Colors.black : null,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class RoundedPinPut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: PinPut(
        fieldsCount: 6,
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
        eachFieldWidth: 40.0,
        eachFieldHeight: 55.0,
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
        onSubmit: (pin) async {
          firebaseService.verifyOTP(context, pin);
        },
      ),
    );
  }
}

class ListDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const ListDrawerItem({
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          leading: Icon(
            icon,
            color: Colors.purple,
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Colors.purple,
          )),
    );
  }
}

class UserRoundedPic extends StatelessWidget {
  UserRoundedPic(
      {@required this.photoSize,
      @required this.onPressed,
      @required this.image});
  final photoSize;
  final Function onPressed;
  final image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: photoSize,
          height: photoSize,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: IconButton(
            icon: Icon(Icons.camera_alt),
            iconSize: 37,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard(
      {this.backgroundColor,
      @required this.onPressed,
      @required this.iconSize,
      @required this.icon,
      @required this.txt,
      this.iconColor});
  final Function onPressed;
  final Color backgroundColor;
  final double iconSize;
  final Color iconColor;
  final String txt;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              IconButton(
                color: iconColor,
                onPressed: onPressed,
                iconSize: iconSize,
                icon: Icon(icon),
              ),
              Expanded(child: Container()),
              Text(
                txt,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'XB_Zar',
                    fontSize: iconSize / 3),
              ),
              Expanded(child: Container()),
            ],
          )),
        ),
      ),
    );
  }
}
