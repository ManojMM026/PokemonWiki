import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_navigator.dart';
import 'package:mypokedex/util/provider_setup.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'pokedex/presentation/screens/splash.dart';

Future<InitializationStatus> initGoogleMobileAds() {
  return MobileAds.instance.initialize();
}

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MultiProvider(providers: providers, child: PokedexApp()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..backgroundColor = Colors.white
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorColor = Colors.blueAccent
    ..textColor = Colors.blueAccent
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..progressColor = Colors.blueAccent
    ..userInteractions = true
    ..dismissOnTap = true;
}

class PokedexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppNavigator.instance.generateRoute,
      title: Strings.appName,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white70,
        textTheme: GoogleFonts.latoTextTheme().copyWith(
          headline1: GoogleFonts.lato(
              fontWeight: FontWeight.bold, color: Colors.black),
          headline2: GoogleFonts.lato(
              fontWeight: FontWeight.bold, color: Colors.black),
          headline3: GoogleFonts.lato(
              fontWeight: FontWeight.bold, color: Colors.black),
          headline4: GoogleFonts.lato(
              fontWeight: FontWeight.bold, color: Colors.black),
          headline5: GoogleFonts.roboto(
              fontWeight: FontWeight.bold, color: Colors.black),
          headline6: GoogleFonts.lato(color: Colors.black),
          subtitle1: GoogleFonts.lato(
              fontWeight: FontWeight.w400, color: Colors.black),
          subtitle2: GoogleFonts.lato(
              fontWeight: FontWeight.w400, color: Colors.black),
          bodyText2: GoogleFonts.lato(
              fontWeight: FontWeight.w300, color: Colors.black),
          caption: GoogleFonts.lato(
              fontWeight: FontWeight.w300, color: Colors.black),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: EasyLoading.init(),
      home: Splash(),
    );
  }
}
