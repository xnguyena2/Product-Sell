import 'dart:convert';

import 'package:flutter/material.dart';

import 'component/main_bars.dart';
import 'constants.dart';
import 'model/boostrap.dart';
import 'page/cart.dart';
import 'page/home.dart';
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

  Future<BootStrap> fetchBootstrap() async {
    final response = await get(Uri.parse('${host}/clientdevice/bootstrap'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return BootStrap.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureBootstrap = fetchBootstrap();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(4),
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
                  MaterialPageRoute(builder: (context) => const Cart()),
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
