import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/routes.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:flutter/services.dart';
import 'package:mbeshtetu_app/src/screens/splash/spash_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';

void main() {
  setupServiceLocator();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: white));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
  )
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mbeshtetu App',
      theme: ThemeData(
          fontFamily: 'Cera',
          primaryColor: bold_blue,
          primarySwatch: Colors.green,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurple, //  <-- dark color
            textTheme: ButtonTextTheme
                .primary, //  <-- this auto selects the right color
          )),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
