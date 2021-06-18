import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tredbook/fUser.dart';

class SubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 80.0), child: SectionObject());
  }
}

class SectionObject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sections = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('subscription');
    return StreamBuilder<QuerySnapshot>(
      stream: sections.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data.docs.map(
                (data) {
                  return GestureDetector(
                    onTap: () {},
                    child: CachedNetworkImage(
                      imageUrl: data.get('activityLogoURL'),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      imageBuilder: (_, imageProvider) => Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.white,
                              backgroundImage: imageProvider,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              data.get('activityName'),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                                fontFamily: 'XB_ZAR',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList());
        }
      },
    );
  }
}
