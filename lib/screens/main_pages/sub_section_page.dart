import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tredbook/screens/main_pages/activities.dart';

import '../../provider_data.dart';

class SubSectionPage extends StatelessWidget {
  static const routeName = "subSectionPage";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var sections = FirebaseFirestore.instance
        .collection('sections')
        .doc(sectionId(context))
        .collection('subsection');

    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset(
                'assets/images/screenTopShape.png',
                width: size.width,
              ),
            ),
            Positioned(
              top: 40.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: sections.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView(
                          children: snapshot.data.docs
                              .map(
                                (data) => GestureDetector(
                                  onTap: () {
                                    setSubSectionId(
                                        context: context, value: data.id);

                                    Navigator.pushNamed(
                                        context, Activites.routeName);
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          radius: 35.0,
                                          backgroundColor: Colors.white,
                                          child: Image.network(
                                            data.get('logoUrl'),
                                          ),
                                        ),
                                        Text(
                                          data.get('nameAr'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                            fontFamily: 'XB_ZAR',
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
