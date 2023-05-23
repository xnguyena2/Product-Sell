import 'package:flutter/material.dart';

import '../component/main_bars.dart';

class MyAppState extends ChangeNotifier {
  VoidCallback? switchSearchPage;
  VoidCallback? showProductDetail;
  GlobalKey<MainBarsState>? myKey;
}
