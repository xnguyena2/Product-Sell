import 'package:flutter/material.dart';
import 'package:product_sell/page/page_index.dart';

import '../component/main_bars.dart';

class MyAppState extends ChangeNotifier {
  VoidCallback? switchSearchPage;
  VoidCallback? showProductDetail;
  VoidCallback? refreshMainBar;
  GlobalKey<MainBarsState>? myKey;
  Map<PageIndex, int> notificationNo = {
    PageIndex.home: 0,
    PageIndex.search: 0,
    PageIndex.cart: 0,
    PageIndex.profile: 0
  };

  void updateNotification(PageIndex index, int no) {
    notificationNo[index] = no;
    refreshMainBar?.call();
    // notifyListeners();
  }
}
