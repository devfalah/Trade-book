import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tredbook/firebaseService.dart';

FirebaseService firebaseService = FirebaseService();

//Const:
final themeColor = Color(0xfff5a623);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);
final String avatarPlaceholderURL =
    'https://banner2.cleanpng.com/20180920/efk/kisspng-user-logo-information-service-design-5ba34f88a0c3a6.5907352915374293846585.jpg';
const sCashedImg = 800;
const lCashedImg = 2000;

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// OTP Consts:
final BoxDecoration pinPutDecoration = BoxDecoration(
  color: const Color.fromRGBO(43, 46, 66, 1),
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
    color: const Color.fromRGBO(126, 203, 224, 1),
  ),
);
final TextEditingController pinPutController = TextEditingController();
final FocusNode pinPutFocusNode = FocusNode();
