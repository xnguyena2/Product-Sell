import 'package:flutter/material.dart';
import 'package:product_sell/model/order_result.dart';

import '../constants.dart';
import 'component/app_bar.dart';

class ThankFull extends StatelessWidget {
  final Future<OrderResult> orderResult;
  const ThankFull({
    super.key,
    required this.orderResult,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<OrderResult>(
        builder: (context, snapshot) {
          return Scaffold(
            appBar: const BackAppBar(),
            backgroundColor: backgroundColor,
            body: FutureBuilder<OrderResult>(
              future: orderResult,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'Cảm ơn bạn đã mua sản phẩm!',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Processing please wait!"),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
