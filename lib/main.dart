import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:precheckin/pages/ChooseLanguage.dart';
import 'package:precheckin/pages/identificacion/PrimerDocumento.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/routes/routes.dart';
import 'package:precheckin/tools/translation.dart';
import 'pages/Splash.dart';
import 'tools/application.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final qrPersistence = new QRPersistence();
  await qrPersistence.initPref();

  final usrPref = UserPreferences();
  await usrPref.initPref();


  runApp(new MyApp());
} 
  

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState(){
    super.initState();
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale){
    setState((){
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'My Application',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFFBF341A)
      ),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: applic.supportedLocales(),
      routes: getApplicationRoutes(),
      initialRoute: "/",
    );
  }
}


class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: SplashPage(),
    );
  }
}