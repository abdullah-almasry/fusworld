import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:fus_world/pages/splash_screen.dart';

import 'functions/localizations.dart';


void main() {
  runApp(
      MyApp()
  );
}





class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state =
    context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);
  }


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: _locale,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],

      localizationsDelegates: [

        AppLocalizations.delegate,

        GlobalMaterialLocalizations.delegate,

        GlobalWidgetsLocalizations.delegate,


      ],

      home: SplashScreenPage(),
    );
  }
}
