import 'package:flutter/material.dart';
import 'package:product_sell/model/order_result.dart';
import 'package:provider/provider.dart';

import '../api/post.dart';
import '../constants.dart';
import '../global/app_state.dart';
import '../model/user_info_query.dart';
import 'component/app_bar.dart';

class ThankFull extends StatelessWidget {
  final Future<OrderResult> orderResult;
  const ThankFull({
    super.key,
    required this.orderResult,
  });

  void fetchPackageResultAgain(MyAppState appState) {
    var futurePackage = fetchPackageResult(UserInfoQuery(0, 0, deviceID));
    appState.setPackageResult(futurePackage);
  }

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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Cảm ơn bạn đã mua sản phẩm!',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            var appState = context.read<MyAppState>();
                            fetchPackageResultAgain(appState);
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.all(15),
                              backgroundColor: activeColor,
                              disabledBackgroundColor: normalBorderColor05),
                          child: const Text(
                            "Trở lại màn hình chính",
                            style: TextStyle(color: secondBackgroundColor),
                          ),
                        )
                      ],
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
