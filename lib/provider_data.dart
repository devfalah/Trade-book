import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tredbook/main.dart';

class ProviderData extends ChangeNotifier {
  String sectionId = "";
  String subSectionId = "";
  String activitiesId = "";
  ThemeData _themeData =
      darkMode ?? false ? ThemeData.dark() : ThemeData.light();
  getTheme() {
    return _themeData;
  }

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void setSectionId({@required value}) {
    sectionId = value;
    notifyListeners();
  }

  void setSubSectionId({@required value}) {
    subSectionId = value;
    notifyListeners();
  }

  void setActivitiesId({@required value}) {
    activitiesId = value;
    notifyListeners();
  }
}

setSectionId({@required context, @required String value}) {
  Provider.of<ProviderData>(context, listen: false).setSectionId(value: value);
}

sectionId(context) {
  return Provider.of<ProviderData>(context, listen: false).sectionId;
}

setSubSectionId({@required context, @required String value}) {
  Provider.of<ProviderData>(context, listen: false)
      .setSubSectionId(value: value);
}

subSectionId(context) {
  return Provider.of<ProviderData>(context, listen: false).subSectionId;
}

setActivitiesId({@required context, @required String value}) {
  Provider.of<ProviderData>(context, listen: false)
      .setActivitiesId(value: value);
}

activitiesId(context) {
  return Provider.of<ProviderData>(context, listen: false).activitiesId;
}
