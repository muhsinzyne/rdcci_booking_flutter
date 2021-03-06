import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rdcciappointment/localization/localization_const.dart';
import 'package:rdcciappointment/providers/global_provider.dart';
import 'package:rdcciappointment/screens/home_screen.dart';

import 'localization/demo_localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  static void updateLoadingStatus(BuildContext context, bool value) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.updateLoader(value);
  }

  static getCurrentLocal(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    final Locale currentLocal = state.getCurrentLocal();
    return currentLocal.languageCode;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  bool loader = false;
  bool appReady = false;

  @override
  void initState() {
    super.initState();
    this._appReadyState();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void updateLoader(bool value) {
    setState(() {
      loader = value;
    });
  }

  Locale getCurrentLocal() {
    return _locale;
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  void _appReadyState() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      appReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null || appReady == false) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          ListenableProvider<GlobalProvider>(create: (_) => GlobalProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          locale: _locale,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ar', 'SA'),
          ],
          localizationsDelegates: [
            DemoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale == null || deviceLocale == null) {}
              if (locale != null) {
                if (locale.languageCode != null) {
                  if (locale.languageCode == deviceLocale.languageCode && locale.countryCode == deviceLocale.countryCode) {
                    return deviceLocale;
                  }
                }
              }
            }

            return supportedLocales.first;
          },
          theme: ThemeData(
            primaryColor: Color(0xff3b5998),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.comfortable,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      );
    }
  }
}
