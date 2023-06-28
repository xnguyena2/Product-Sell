import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'global/app_state.dart';
import 'entry_point.dart';
import 'my_custom_scroll_behavior.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  getDeviceID();
  runApp(const MyApp());
}

void getDeviceID() async {
  var box = Hive.box('settings');
  String? device_id = await box.get('deviceID');
  if (device_id == null) {
    print("create new device ID");
    device_id = "1687247699000";
    box.put('deviceID', device_id);
  }
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
