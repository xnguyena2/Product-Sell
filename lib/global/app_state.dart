import 'package:flutter/material.dart';

import '../component/main_bars.dart';

class MyAppState extends ChangeNotifier {
  VoidCallback? switchSearchPage;
  GlobalKey<MainBarsState>? myKey;
}
