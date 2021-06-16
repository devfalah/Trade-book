import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:tredbook/appBrain.dart';
import 'package:tredbook/components.dart';
import 'package:tredbook/fUser.dart';
import 'dart:ui' as ui;

class UserProfileScreen extends StatefulWidget {
  static const routeName = "userProfileScreen";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File _image;

  final picker = ImagePicker();
  var _displayName = TextEditingController();
  var _displayEmail = TextEditingController();
  var _displaPhone = TextEditingController();
  var _barcodeKey = GlobalKey();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool _uploading = false;
  bool _edited = false;
  String imageUrl;
  @override
  void initState() {
    getUserProfile();
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
          title: Text("User Profile"),
          centerTitle: true,
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  shareImage();
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                      icon: Icon(!_edited ? Icons.edit : Icons.save,
                          color: Colors.purple),
                      onPressed: () {
                        setState(() {
                          updateUserProfile();
                          _edited = !_edited;
                        });
                      }),
                  Column(
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: UserRoundedPic(
                          photoSize: 130.0,
                          onPressed: () {
                            getImage();
                          },
                          image: _image == null
                              ? NetworkImage(imageUrl == null
                                  ? avatarPlaceholderURL
                                  : imageUrl)
                              : FileImage(_image),
                        ),
                      ),
                      if (_uploading) LinearProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.all(_edited ? 30.0 : 8.0),
                        child: Column(
                          children: [
                            _edited
                                ? TextField(
                                    controller: _displayName,
                                    decoration: InputDecoration(
                                      labelText: "Display name",
                                      hintText: "Enter your name",
                                    ),
                                  )
                                : Text(_displayName.text),
                            SizedBox(height: 10.0),
                            _edited
                                ? TextField(
                                    controller: _displayEmail,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      hintText: "Enter your email",
                                    ),
                                  )
                                : Text(_displayEmail.text),
                            SizedBox(height: 20.0),
                            _edited
                                ? TextField(
                                    controller: _displaPhone,
                                    decoration: InputDecoration(
                                      labelText: "Display Phone",
                                      hintText: "Enter your Phone",
                                    ),
                                  )
                                : Text(_displaPhone.text),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                      RepaintBoundary(
                        key: _barcodeKey,
                        child: Container(
                          color: Colors.white,
                          child: BarcodeWidget(
                            color: Colors.purple[700],
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 2,
                            barcode: Barcode.qrCode(),
                            data: auth.currentUser.uid,
                            errorBuilder: (context, error) =>
                                Center(child: Text(error)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  shareImage() async {
    try {
      RenderRepaintBoundary boundary =
          _barcodeKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asInt8List();

      String dir = (await getApplicationDocumentsDirectory()).path;
      File file =
          File("$dir/" + DateTime.now().microsecond.toString() + ".png");
      await file.writeAsBytes(pngBytes);
      Share.shareFiles([file.path],
          text: 'tradebook user: ${_displayName.text}');
    } catch (e) {}
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadAndUpdate();
      } else {
        print('No image selected.');
      }
    });
  }

  uploadAndUpdate() async {
    setState(() {
      _uploading = true;
    });
    final storage = FirebaseStorage.instance;

    var file = File(_image.path);
    final snap = await storage
        .ref()
        .child("userPhotos/${auth.currentUser.uid}")
        .putFile(file)
        .whenComplete(() {
      setState(() {
        _uploading = false;
      });
    });
    var url = snap.ref.getDownloadURL();

    DocumentReference ref = db.collection('users').doc(auth.currentUser.uid);
    return ref.update(
      {
        'photoUrl': url,
      },
    );
  }

  updateUserProfile() {
    if (_edited) {
      DocumentReference ref = db.collection('users').doc(auth.currentUser.uid);
      return ref.set(
        {
          'email': _displayEmail.text,
          'displayName': _displayName.text,
          'lastSeen': DateTime.now(),
          'phone': _displaPhone.text,
          'photoUrl': imageUrl,
        },
      );
    }
  }

  getUserProfile() {
    DocumentReference ref = db.collection('users').doc(auth.currentUser.uid);
    ref.get().then((value) => setState(() {
          if (value.data() != null) {
            imageUrl = value.get('photoUrl');
            _displayName.text = value.get('displayName');
            _displayEmail.text = value.get('email');
            _displaPhone.text = value.get('phone');
          }
        }));
  }
}
