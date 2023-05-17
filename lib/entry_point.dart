import 'package:flutter/material.dart';

import 'compoment/main_bars.dart';
import 'constants.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(4),
          // margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            // borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: const MainBars(),
        ),
        body: Container(),
      ),
    );
  }
}
