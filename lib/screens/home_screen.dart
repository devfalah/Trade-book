import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tredbook/components.dart';
import 'package:tredbook/screens/admin_pages/admin_home_page.dart';
import 'package:tredbook/screens/main_pages/show_page.dart';
import 'package:tredbook/screens/main_pages/subscriptions_page.dart';
import 'package:tredbook/screens/user_profile_screen.dart';

import '../appBrain.dart';
import 'main_pages/home_page.dart';
import 'main_pages/jobs_page.dart';

class HomeScreen extends StatefulWidget {
  static const id = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  int acsses = 0;
  final List<Widget> _pages = [
    HomePage(),
    ShowPage(),
    SubscriptionsPage(),
    JobsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  acsses++;
                  if (acsses == 5) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AdminHomePage.routeName)
                        .then((value) {
                      acsses = 0;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/appstore.gif',
                      width: 80,
                    ),
                    Text(
                      "TradeBook",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.deepPurple,
                  ],
                ),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(avatarPlaceholderURL),
              ),
            ),
            ListDrawerItem(
              title: "User Profile",
              icon: FontAwesomeIcons.user,
              onTap: () {
                Navigator.pushNamed(context, UserProfileScreen.routeName);
              },
            ),
            ListDrawerItem(title: "User Profile", icon: FontAwesomeIcons.bell),
            ListDrawerItem(title: "User Profile", icon: Icons.settings),
            ListDrawerItem(
                title: "User Profile", icon: FontAwesomeIcons.signOutAlt),
          ],
        ),
      ),
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
                right: 0.0,
                child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      scaffoldKey.currentState.openEndDrawer();
                    })),
            Positioned(
              top: 40.0,
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            Center(
              child: _pages[_index],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 400),
        color: Colors.purple,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        height: 50,
        items: [
          Icon(Icons.home, size: 30),
          Icon(FontAwesomeIcons.windows, size: 30),
          Icon(Icons.subscriptions, size: 30),
          Icon(Icons.work, size: 30),
        ],
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
