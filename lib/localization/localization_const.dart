import 'package:flutter/cupertino.dart';
import 'package:rdcciappointment/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslate(BuildContext context, String key) {
  return DemoLocalizations.of(context).getTranslatedValue(key);
}

const String ENGLISH = 'en';
const String ARABIC = 'ar';
const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  await _pref.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ARABIC:
      _temp = Locale(languageCode, 'SA');
      break;
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}
