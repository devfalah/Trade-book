import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tredbook/language.dart';
import 'package:tredbook/main.dart';
import 'package:tredbook/provider_data.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "SettingsScreen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _languages = ['AR', 'EN', 'TR'];
  String _selectedLanguage;
  bool _darkMode = false;
  bool _notifications = false;

  @override
  void initState() {
    super.initState();
    getSelectedPref();
    setState(() {
      _darkMode = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _language = Provider.of<Language>(context);
    var theme = Provider.of<ProviderData>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.purple,
              margin: const EdgeInsets.all(0),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 33,
                ),
                title: Text(
                  _language.tSettings(),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  ListTile(
                    title: Text(_language.tChangeLanguage()),
                    leading: Icon(
                      FontAwesomeIcons.language,
                      color: Colors.purple,
                    ),
                    trailing: DropdownButton(
                        hint: Text(_language.tLanguage()),
                        value: _selectedLanguage,
                        onChanged: (newValue) async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString('language', newValue);
                          _language.setLanguage(newValue);

                          setState(() {
                            _selectedLanguage = newValue;
                          });
                        },
                        items: _languages.map((lang) {
                          return DropdownMenuItem(
                            child: Text(lang),
                            value: lang,
                          );
                        }).toList()),
                  ),
                  ListTile(
                    title: Text(_language.tDarkMode()),
                    leading: Icon(
                      FontAwesomeIcons.brush,
                      color: Colors.black,
                    ),
                    trailing: Switch(
                      activeColor: Colors.teal,
                      value: _darkMode ?? false,
                      onChanged: (val) async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool('darkMode', val);
                        theme.setTheme(
                            darkMode ? ThemeData.light() : ThemeData.dark());

                        setState(() {
                          _darkMode = val;
                          darkMode = val;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Receive Notifications'),
                      leading: Icon(
                        FontAwesomeIcons.bell,
                        color: Colors.red,
                      ),
                      trailing: Switch(
                        activeColor: Colors.teal,
                        value: _notifications ?? false,
                        onChanged: (val) async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setBool('notifications', val);

                          setState(() {
                            _notifications = val;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Functions:

  getSelectedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = pref.getString('language');
      _darkMode = pref.getBool('darkMode');
      _notifications = pref.getBool('notifications');
    });
  }
}
