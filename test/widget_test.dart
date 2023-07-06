// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_sell/api/post.dart';
import 'package:product_sell/constants.dart';

import 'package:product_sell/main.dart';
import 'package:product_sell/model/fcm_token.dart';
import 'package:product_sell/model/order_result.dart';
import 'package:product_sell/model/package_order.dart';
import 'dart:io';

void init() {
  HttpOverrides.global = MyHttpOverrides();
  deviceID = "1687247699000";
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await Future.delayed(Duration(seconds: 1));
      init();
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that our counter starts at 0.
      // expect(find.text('Free ship đơn hàng trên 1 triệu!'), findsOneWidget);
      expect(find.image(const AssetImage('assets/icons/SearchBar.png')),
          findsOneWidget);

      expect(find.text('Shopping Cart'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.widgetWithImage(
          IconButton,
          const AssetImage(
              'assets/icons/SearchBar.png'))); //assets/icons/Package.png

      await tester.pump();

      expect(find.text('huda hue'), findsOneWidget);

      await tester.tap(find.widgetWithImage(
          IconButton,
          const AssetImage(
              'assets/icons/Package.png'))); //assets/icons/Package.png
      await tester.pump();

      expect(find.byWidgetPredicate((widget) {
        if (widget is Text) {
          final Text textWidget = widget;
          print(textWidget.data);
          if (textWidget.data != null) {
            return textWidget.data!.contains('huda hue');
          }
          return textWidget.textSpan!.toPlainText().contains('huda hue');
        }
        return false;
      }), findsOneWidget);

      expect(find.text('Search Product', findRichText: true), findsOneWidget);
      // Verify that our counter has incremented.
      await tester.pump();
      expect(find.text('Tổng Tiền:'), findsOneWidget);
      expect(find.text('Shopping Cart'), findsOneWidget);
    });
  });

  test('pre order test', () async {
    init();
    final parameter = Order(
        preOrder: true,
        packageOrder: PackageOrder(
            userDeviceId: "1687247699000",
            reciverAddress: "",
            regionId: 294,
            districtId: 496,
            wardId: 0,
            reciverFullname: "",
            phoneNumber: "",
            totalPrice: 0,
            shipPrice: 0),
        beerOrders: [
          BeerOrders(
              beerOrder: BeerOrder(
                  beerSecondId: "beer_order2",
                  voucherSecondId: "",
                  totalPrice: 0,
                  shipPrice: 0),
              beerUnitOrders: [
                BeerUnitOrders(
                    beerSecondId: "beer_order2",
                    beerUnitSecondId: "5bda2d723f104189998550786d0ae50a",
                    numberUnit: 1,
                    price: 0,
                    totalDiscount: 0)
              ])
        ]);
    final result = await createOrder(parameter);

    expect(result.totalPrice, 0);
  });

  test('device sumit fcm token', () async {
    init();
    final parameter = FCMToken(
      deviceId: "1687247699000",
      fcmId: "hello",
    );
    final result = await submitFCMToken(parameter);

    expect(result, "");
  });
}
