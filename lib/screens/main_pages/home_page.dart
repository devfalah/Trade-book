import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tredbook/language.dart';
import 'package:tredbook/provider_data.dart';
import 'package:tredbook/screens/main_pages/sub_section_page.dart';

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
    var _language = Provider.of<Language>(context, listen: false);

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
              children: snapshot.data.docs.map(
                (data) {
                  String selectedLang() {
                    if (_language.getLanguage() == 'AR') {
                      return data.get('nameAr');
                    } else if (_language.getLanguage() == 'EN')
                      return data.get('nameEn');
                    return "";
                  }

                  return GestureDetector(
                    onTap: () {
                      setSectionId(context: context, value: data.id);

                      Navigator.pushNamed(context, SubSectionPage.routeName);
                    },
                    child: CachedNetworkImage(
                      imageUrl: data.get('logoUrl'),
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
                              selectedLang(),
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
