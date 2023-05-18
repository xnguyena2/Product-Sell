import 'package:flutter/material.dart';

import 'component/list_product.dart';
import 'component/main_bars.dart';
import 'component/search_bar.dart';
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
          decoration: const BoxDecoration(
            color: dartBackgroundColor,
            // borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: const MainBars(),
        ),
        body: const Column(
          verticalDirection: VerticalDirection.up,
          children: [
            ListProduct(),
            SearchButton(),
          ],
        ),
      ),
    );
  }
}
