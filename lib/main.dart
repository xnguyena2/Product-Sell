import 'package:flutter/material.dart';
import 'package:product_sell/page/cart.dart';
import 'package:product_sell/page/product_detail.dart';
import 'package:provider/provider.dart';

import 'global/app_state.dart';
import 'entry_point.dart';
import 'my_custom_scroll_behavior.dart';

void main() {
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
