import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:tredbook/ads_manger.dart';
import 'package:tredbook/screens/main_pages/activities_home_page.dart';

import '../../provider_data.dart';

class Activites extends StatefulWidget {
  static const routeName = "activites";

  @override
  _ActivitesState createState() => _ActivitesState();
}

class _ActivitesState extends State<Activites> {
  final _nativeAdController = NativeAdmobController();

  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  @override
  void initState() {
    super.initState();

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var sections = FirebaseFirestore.instance
        .collection('sections')
        .doc(sectionId(context))
        .collection('subsection')
        .doc(subSectionId(context))
        .collection('activities');

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
              child: Column(
                children: [
                  SizedBox(height: 80.0),
                  Expanded(
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
                                        setActivitiesId(
                                            context: context, value: data.id);
                                        interstitialAd.show();

                                        Navigator.pushNamed(context,
                                            ActivitesHomePage.routeName);
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                              radius: 35.0,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  data.get('logoUrl')),
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
                  Expanded(child: _nativeAdContainer()),
                  Spacer(),
                  _bannerAd(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerAd() {
    return AdmobBanner(
      adUnitId: AdsManager.bannerAdUnitId,
      adSize: AdmobBannerSize.BANNER,
    );
  }

  Widget _nativeAdContainer() {
    return Container(
      margin: EdgeInsets.all(30),
      height: 100,
      child: NativeAdmob(
        adUnitID: AdsManager.nativeAdUnitId,
        numberAds: 3,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
      ),
    );
  }
}
