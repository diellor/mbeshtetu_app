import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mbeshtetu_app/routes.dart';
import 'package:mbeshtetu_app/src/business_logic/internet_check.dart';
import 'package:mbeshtetu_app/src/business_logic/page_manager.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/video_model_arg.dart';
import 'package:mbeshtetu_app/src/network_indicator.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/spash_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:overlay_support/overlay_support.dart';
import 'src/models/video_model.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(OverlaySupport(
      child: MaterialApp(
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
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
    ));
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
    //Check connection
    OverlaySupportEntry entry;
    DataConnectivityService()
        .connectivityStreamController
        .stream
        .listen((event) {
      print(event);
      if (event == DataConnectionStatus.disconnected) {
        entry = showOverlayNotification((context) {
          return NetworkErrorAnimation();
        }, duration: Duration(hours: 1));
      } else {
        if (entry != null) {
          entry.dismiss();
        }
      }
    });

    super.initState();
    //serviceLocator<PageManager>().init();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      print("videoid"+message.data["videoId"]);
      print("title"+message.data["title"]);
      if (message.data["videoId"] != null && !message.data["videoId"].toString().endsWith("mp3")) {
        Navigator.of(context)
            .pushNamed(VideoScreen.routeName, arguments: VideoArgs(video: Video(videoId: message.data["videoId"], title: message.data["title"])));
      } else {
        print(message.data["category"]);
        Navigator.of(context)
            .pushNamed(MusicScreen.routeName, arguments: Audio(video: Video(videoId: message.data["videoId"], title: message.data["title"]) ));
      }
    });
  }
  //DISPOSE INIT PANGEMANGER
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
