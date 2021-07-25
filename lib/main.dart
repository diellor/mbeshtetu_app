import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mbeshtetu_app/routes.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/screens/intro/intro_screen.dart';
import 'package:mbeshtetu_app/src/screens/meditations/components/pre_meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/spash_screen.dart';
import 'package:mbeshtetu_app/src/screens/tabs/tabs_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:overlay_support/overlay_support.dart';

import 'src/screens/home/components/video_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
String videoId = "";

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.subscribeToTopic(deviceId);

  print('Handling a background message ${message.messageId}');
  print(message.data);
  videoId = message.data["videoId"];
  showSimpleNotification(
    Container(child: Text(message.notification.title)),
    position: NotificationPosition.top,
  );
}

Uri getApiUri(String path) {
  return Uri.http(
    '134.122.86.217:3000',
    '/$path',
  );
}

Future<String> getDeviceDetails() async {
  String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      identifier = build.androidId; //UUID for Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor; //UUID for iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

  return identifier;
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  setupServiceLocator();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: black));
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(home: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    if (videoId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: videoId),
        ),
      );
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");

      Navigator.push(
          navigatorKey.currentState.context,
          MaterialPageRoute(
              builder: (context) => VideoScreen(
                    id: message.data["videoId"],
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mbeshtetu App',
      navigatorKey: navigatorKey,
      theme: ThemeData(
          fontFamily: 'Cera',
          primaryColor: bold_blue,
          primarySwatch: Colors.green,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurple, //  <-- dark color
            textTheme: ButtonTextTheme
                .primary, //  <-- this auto selects the right color
          ),
      ),
      initialRoute: IntroScreen.routeName,
      routes: routes,
    );
  }
}
