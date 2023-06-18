import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_sell/page/cart.dart';
import 'package:product_sell/page/product_detail.dart';
import 'package:provider/provider.dart';

import 'global/app_state.dart';
import 'entry_point.dart';
import 'my_custom_scroll_behavior.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
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
