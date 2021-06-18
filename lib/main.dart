import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tredbook/language.dart';
import 'package:tredbook/provider_data.dart';
import 'package:tredbook/screens/admin_pages/admin_home_page.dart';

import 'package:tredbook/screens/login_screen.dart';
import 'package:tredbook/screens/main_pages/activities_home_page.dart';
import 'package:tredbook/screens/main_pages/sub_section_page.dart';
import 'package:tredbook/screens/phone_auth_screen.dart';
import 'package:tredbook/screens/setting_screen.dart';
import 'package:tredbook/screens/user_profile_screen.dart';

import 'screens/home_screen.dart';
import 'screens/main_pages/activities.dart';

String language = 'EN';
bool darkMode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences.getInstance().then((instance) {
    language = instance.getString('language') ?? "EN";
    darkMode = instance.getBool('darkMode') ?? true;
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderData()),
        ChangeNotifierProvider(create: (_) => Language()),
      ],
      child: TradeBookTheme(),
    );
  }
}

class TradeBookTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ProviderData>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade book',
      theme: theme.getTheme(),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        PhoneAuthScreen.id: (_) => PhoneAuthScreen(),
        AdminHomePage.routeName: (_) => AdminHomePage(),
        UserProfileScreen.routeName: (_) => UserProfileScreen(),
        SubSectionPage.routeName: (_) => SubSectionPage(),
        ActivitesHomePage.routeName: (_) => ActivitesHomePage(),
        Activites.routeName: (_) => Activites(),
        SettingsScreen.routeName: (_) => SettingsScreen(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
