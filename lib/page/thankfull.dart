import 'package:flutter/material.dart';

import '../constants.dart';
import 'component/app_bar.dart';

class ThankFull extends StatefulWidget {
  const ThankFull({
    super.key,
  });

  @override
  State<ThankFull> createState() => _ThankFullState();
}

class _ThankFullState extends State<ThankFull> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          appBar: BackAppBar(),
          backgroundColor: backgroundColor,
          body: Center(
            child: Text(
              'Cảm ơn bạn đã mua sản phẩm!',
              style: TextStyle(fontSize: 18),
            ),
          )),
    );
  }
}
