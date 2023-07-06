import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'api/post.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'global/app_state.dart';
import 'entry_point.dart';
import 'model/fcm_token.dart';
import 'my_custom_scroll_behavior.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void setToken(String? token) {
  print('FCM Token: $token');
  if (token != null) {
    final parameter = FCMToken(
      deviceId: deviceID,
      fcmId: token,
    );
    submitFCMToken(parameter);
  }
}

Future<void> setupHiveDB() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveSettingBox);
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await setupHiveDB();

  getDeviceID();

  setupInteractedMessage();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
void _handleMessage(RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
  print('Message data: ${message.data}');
  print(message);
  if (message.data['type'] == 'chat') {}
  showFlutterNotification(message);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> setupInteractedMessage() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging
      .requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  )
      .then((settings) {
    print('User granted permission: ${settings.authorizationStatus}');
  });

  // await messaging.setAutoInitEnabled(true);
  messaging.getToken().then(setToken);
  // vapidKey:
  //     'BNi5iH-N5Z2OX_GoueEbzDNBXMYOsAag3XRsi5Y-MMOM8gX3mdbS5hWHgLNPJzXTWszeB2N7vebq5CX1h6xtH2M');

  messaging.onTokenRefresh.listen(setToken).onError((err) {
    print(err);
  });

  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage = await messaging.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessage.listen(_handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

void getDeviceID() {
  var box = Hive.box(hiveSettingBox);
  String? device_id = box.get('deviceID');
  if (device_id == null) {
    print("create new device ID");
    device_id = "1687247699000";
    box.put('deviceID', device_id);
  }
  // box.delete(hiveListAddressID);
  // box.delete(hiveDefaultAddressID);
  print('device id: $device_id');
  print(DateTime.now().millisecondsSinceEpoch);
  deviceID = device_id;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Shop Demo',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        color: Colors.black,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const EntryPoint(),
      ),
    );
  }
}
