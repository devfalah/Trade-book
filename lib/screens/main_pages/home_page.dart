import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 80.0), child: SectionObject());
  }
}

class SectionObject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sections = FirebaseFirestore.instance.collection('sections');
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
              children: snapshot.data.docs
                  .map(
                    (data) => Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: Image.network(
                              data.get('logoUrl'),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            data.get('nameAr'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                              fontFamily: 'XB_ZAR',
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList());
        }
      },
    );
  }
}
