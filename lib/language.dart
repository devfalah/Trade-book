import 'package:flutter/material.dart';
import 'package:tredbook/main.dart';

class Language extends ChangeNotifier {
  String _lang = language;

  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
    notifyListeners();
  }

  ///User Profile translated Strings
  String tSettings() {
    if (getLanguage() == 'AR') {
      return "الإعدادات";
    } else if (getLanguage() == 'EN') {
      return "Settings";
    } else {
      return "Ayarlar";
    }
  }

  String tLanguage() {
    if (getLanguage() == 'AR') {
      return "اللغة";
    } else if (getLanguage() == 'EN') {
      return "Language";
    } else {
      return "Dil";
    }
  }

  String tChangeLanguage() {
    if (getLanguage() == 'AR') {
      return "تبديل اللغة";
    } else if (getLanguage() == 'EN') {
      return "Change Language";
    } else {
      return "Dili değiştir";
    }
  }

  String tDarkMode() {
    if (getLanguage() == 'AR') {
      return "الوضع الليلي";
    } else if (getLanguage() == 'EN') {
      return "Dark Mode";
    } else {
      return "Karanlık Mod";
    }
  }

  String tReceiveNotifications() {
    if (getLanguage() == 'AR') {
      return "تلقي الإشعارات";
    } else if (getLanguage() == 'EN') {
      return "Receive Notifications";
    } else {
      return "Bildirimleri al";
    }
  }
}
