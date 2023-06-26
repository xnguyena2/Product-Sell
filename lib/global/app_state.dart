import 'package:flutter/material.dart';
import 'package:product_sell/page/page_index.dart';

import '../component/main_bars.dart';
import '../model/package_result.dart';

class MyAppState extends ChangeNotifier {
  VoidCallback? switchSearchPage;
  VoidCallback? showProductDetail;
  VoidCallback? refreshMainBar;
  GlobalKey<MainBarsState>? myKey;

  late Future<PackageResult> futurePackage;

  Map<PageIndex, int> notificationNo = {
    PageIndex.home: 0,
    PageIndex.search: 0,
    PageIndex.cart: 0,
    PageIndex.profile: 0
  };

  void updateNotification(PageIndex index, int no) {
    notificationNo[index] = no;
    refreshMainBar?.call();
  }

  Future<PackageResult> setPackageResult(Future<PackageResult> futurePackage) {
    this.futurePackage = futurePackage;
    return futurePackage.then((value) {
      updateNotification(PageIndex.cart, value.calcTotal());
      return value;
    });
  }
}
