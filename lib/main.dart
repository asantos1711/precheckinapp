import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/routes/routes.dart';
import 'package:precheckin/tools/translation.dart';
import 'pages/Splash.dart';
import 'tools/application.dart';
import 'package:precheckin/providers/configuracion_provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  
  final qrPersistence = new QRPersistence();//Inicializar la clase que almacenará los códigos qr proceasdos.
  await qrPersistence.initPref();

  final usrPref = UserPreferences();//Inicializar la clase para almacenar parémetros que se usan durante el procesp de precheckin.
  await usrPref.initPref();

  final config = ConfiguracionProvider(); //Inicializar los parámetros de conficguración de la aplicación.
  await config.initData();

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
        primarySwatch: Colors.red,
        primaryColor: Color.fromRGBO(191, 52, 26, 1),
        accentColor: Color.fromRGBO(191, 52, 26, 1),
        splashColor: Color.fromRGBO(191, 52, 26, 1),
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[300],
      systemNavigationBarColor:  Colors.red
    ));
    return new Scaffold(
      body: SplashPage(),
    );
  }
}