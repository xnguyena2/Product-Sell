import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product_sell/api/post.dart';
import 'package:product_sell/model/user_info_query.dart';
import 'package:provider/provider.dart';

import 'component/main_bars.dart';
import 'constants.dart';
import 'global/app_state.dart';
import 'model/address_data.dart';
import 'model/boostrap.dart';
import 'model/package_result.dart';
import 'page/cart.dart';
import 'page/home.dart';
import 'page/location_select.dart';
import 'page/page_index.dart';
import 'page/search.dart';
import 'package:http/http.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  PageIndex currentPage = PageIndex.home;
  late Future<BootStrap> futureBootstrap;
  late Future<PackageResult> futurePackage;

  Future<BootStrap> fetchBootstrap() async {
    final response = await get(Uri.parse('${host}/clientdevice/bootstrap'));

    if (response.statusCode == 200) {
      // print(response.body);
      return BootStrap.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    if (kReleaseMode) {
      print("release");
      futureBootstrap = fetchBootstrap();
    } else {
      // futureBootstrap = Future.value(bootStrapDebugValue());
      futureBootstrap = fetchBootstrap();
      print("debug");
    }
    futurePackage = fetchPackageResult(UserInfoQuery(0, 0, deviceID));
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.read<MyAppState>();
    appState.setPackageResult(futurePackage);

    Widget page;
    switch (currentPage) {
      case PageIndex.cart:
      case PageIndex.home:
        page = HomePage(
          futureBootstrap: futureBootstrap,
        );
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
          padding: const EdgeInsets.only(
            top: 4,
          ),
          // margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: dartBackgroundColor,
            // borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: MainBars(
            switchPage: (pageIndex) {
              if (pageIndex == PageIndex.cart) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Cart(
                            buyPackage: null,
                          )),
                );
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
