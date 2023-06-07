import 'package:flutter/material.dart';

import 'component/main_bars.dart';
import 'constants.dart';
import 'page/cart.dart';
import 'page/home.dart';
import 'page/page_index.dart';
import 'page/search.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  PageIndex currentPage = PageIndex.home;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentPage) {
      case PageIndex.cart:
      case PageIndex.home:
        page = const HomePage();
        break;
      case PageIndex.search:
        page = const SearchPage();
        break;
      default:
        page = const Placeholder();
        break;
      // default:
      //   throw UnimplementedError('no widget for $currentPage');
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(4),
          // margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: dartBackgroundColor,
            // borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: MainBars(
            switchPage: (pageIndex) {
              if (pageIndex == PageIndex.cart) {
              } else {
                setState(() {
                  currentPage = pageIndex;
                });
              }
            },
            pageIndex: currentPage,
          ),
        ),
        body: page,
      ),
    );
  }
}
