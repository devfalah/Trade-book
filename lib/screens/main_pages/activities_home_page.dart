import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tredbook/firebaseService.dart';
import 'package:tredbook/location_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components.dart';
import '../../fUser.dart';
import '../../provider_data.dart';

class ActivitesHomePage extends StatefulWidget {
  static const routeName = 'ActivityHomePage';
  @override
  _ActivitesHomePageState createState() => _ActivitesHomePageState();
}

class _ActivitesHomePageState extends State<ActivitesHomePage> {
  FirebaseService _service = FirebaseService();
  String _logoURL = '';
  String _nameAR = '';
  double longitude = 0.0;
  double latitude = 0.0;
  String whatsapp;
  @override
  void initState() {
    getActivityProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LocationService().sendLocationToDataBase(context);
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(_logoURL),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _nameAR,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Facebook',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blueAccent,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Twitter',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Youtube',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Instagram',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.deepOrange,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Site',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.web,
                  color: Colors.purple,
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Positioned(
            top: 25.0,
            child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _nameAR,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'XB_Zar',
                            fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        //borderRadius: BorderRadius.circular(20),
                        image: new DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(_logoURL),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _service.db
                            .collection('sections')
                            .doc(sectionId(context))
                            .collection('subsection')
                            .doc(subSectionId(context))
                            .collection('activities')
                            .doc(activitiesId(context))
                            .collection('likeduser')
                            .doc(auth.currentUser.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.red,
                              ),
                            );
                          }
                          if (snapshot.data.exists) {
                            return IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                addLike(true);
                              },
                            );
                          } else {
                            return IconButton(
                              icon: Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                addLike(false);
                              },
                            );
                          }
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _service.db
                            .collection('sections')
                            .doc(sectionId(context))
                            .collection('subsection')
                            .doc(subSectionId(context))
                            .collection('activities')
                            .doc(activitiesId(context))
                            .collection('likeduser')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.docs.length.toString());
                          } else {
                            return Text("0");
                          }
                        },
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: Icon(
                          Icons.add_comment,
                          color: Colors.teal,
                        ),
                        onPressed: () {},
                      ),
                      Text('التعليقات'),
                      Expanded(child: Container()),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _service.db
                            .collection('sections')
                            .doc(sectionId(context))
                            .collection('subsection')
                            .doc(subSectionId(context))
                            .collection('activities')
                            .doc(activitiesId(context))
                            .collection('followedUsers')
                            .doc(auth.currentUser.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Icon(
                                Icons.attachment_rounded,
                                color: Colors.red,
                              ),
                            );
                          }
                          if (snapshot.data.exists) {
                            return IconButton(
                              icon: Icon(
                                Icons.attachment_rounded,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                follow(true);
                              },
                            );
                          } else {
                            return IconButton(
                              icon: Icon(
                                Icons.attachment_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                follow(false);
                              },
                            );
                          }
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _service.db
                            .collection('sections')
                            .doc(sectionId(context))
                            .collection('subsection')
                            .doc(subSectionId(context))
                            .collection('activities')
                            .doc(activitiesId(context))
                            .collection('followedUsers')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.docs.length.toString());
                          } else {
                            return Text("0");
                          }
                        },
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              CustomCard(
                                onPressed: () {
                                  LocationService()
                                      .goToMaps(latitude, longitude);
                                },
                                txt: 'الموقع',
                                icon: FontAwesomeIcons.searchLocation,
                                iconColor: Colors.red,
                                iconSize: MediaQuery.of(context).size.width / 6,
                              ),
                              CustomCard(
                                onPressed: () {
                                  print('ljlk');
                                },
                                txt: 'المتجر',
                                icon: FontAwesomeIcons.store,
                                iconColor: Colors.blueAccent,
                                iconSize: MediaQuery.of(context).size.width / 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              CustomCard(
                                txt: 'المعرض',
                                icon: FontAwesomeIcons.photoVideo,
                                iconColor: Colors.deepOrange,
                                iconSize: MediaQuery.of(context).size.width / 6,
                                onPressed: () {},
                              ),
                              CustomCard(
                                onPressed: () {
                                  sendWhatsAppMessage(
                                    message: "مرحبا $_nameARمن تطبيق تريدبوك",
                                    phone: whatsapp,
                                  );
                                },
                                txt: 'اتصل بنا',
                                icon: FontAwesomeIcons.whatsapp,
                                iconColor: Colors.green,
                                iconSize: MediaQuery.of(context).size.width / 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void sendWhatsAppMessage({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=$message";
      }
    }

    await canLaunch(url())
        ? launch(url())
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('There is no WhatsApp on your Device!')));
  }

  void follow(bool follow) {
    follow = !follow;
    if (follow) {
      DocumentReference ref = _service.db
          .collection('sections')
          .doc(sectionId(context))
          .collection('subsection')
          .doc(subSectionId(context))
          .collection('activities')
          .doc(activitiesId(context))
          .collection('followedUsers')
          .doc(auth.currentUser.uid);
      ref.set(
        {
          'logoURL': auth.currentUser.photoURL,
          'nameAR': auth.currentUser.displayName,
          'createDate': DateTime.now(),
        },
      );

      DocumentReference ref1 = _service.db
          .collection('users')
          .doc(auth.currentUser.uid)
          .collection('subscription')
          .doc(activitiesId(context));
      ref1.set(
        {
          'activityLogoURL': _logoURL,
          'activityName': _nameAR,
          'activitySection': sectionId(context),
          'activitySubSection': subSectionId(context),
          'createDate': DateTime.now(),
        },
      );
    } else {
      DocumentReference ref = _service.db
          .collection('sections')
          .doc(sectionId(context))
          .collection('subsection')
          .doc(subSectionId(context))
          .collection('activities')
          .doc(activitiesId(context))
          .collection('followedUsers')
          .doc(auth.currentUser.uid);
      ref.delete();

      DocumentReference ref1 = _service.db
          .collection('users')
          .doc(auth.currentUser.uid)
          .collection('subscriptions')
          .doc(activitiesId(context));
      ref1.delete();
    }
  }

  addLike(bool liked) async {
    liked = !liked;
    if (liked) {
      final ref = _service.db
          .collection('sections')
          .doc(sectionId(context))
          .collection('subsection')
          .doc(subSectionId(context))
          .collection('activities')
          .doc(activitiesId(context))
          .collection('likeduser')
          .doc(auth.currentUser.uid);
      ref.set({
        'logoUrl': auth.currentUser.photoURL,
        'name': auth.currentUser.displayName,
        'createDate': DateTime.now(),
      });
    } else {
      final ref = _service.db
          .collection('sections')
          .doc(sectionId(context))
          .collection('subsection')
          .doc(subSectionId(context))
          .collection('activities')
          .doc(activitiesId(context))
          .collection('likeduser')
          .doc(auth.currentUser.uid);
      ref.delete();
    }
  }

  getActivityProfile() async {
    DocumentReference ref = _service.db
        .collection('sections')
        .doc(sectionId(context))
        .collection('subsection')
        .doc(subSectionId(context))
        .collection('activities')
        .doc(activitiesId(context));
    ref.get().then(
          (doc) => {
            setState(() {
              if (doc.data() != null) {
                _logoURL = doc.get('logoUrl');
                _nameAR = doc.get('nameAr');
                whatsapp = doc.get('phone');
                longitude = doc.get('longitude') ?? 0.0;
                latitude = doc.get('latitude') ?? 0.0;
              }
            })
          },
        );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.purple[600];
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
