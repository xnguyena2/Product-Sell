import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../component/list_product.dart';
import '../component/search_bar.dart';
import '../constants.dart';
import '../model/boostrap.dart';
import '../model/search_query.dart';
import '../model/search_result.dart';
import 'component/carousel.dart';

class HomePage extends StatefulWidget {
  final Future<BootStrap> futureBootstrap;

  const HomePage({
    super.key,
    required this.futureBootstrap,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<SearchResult>? futureLoadMore;
  bool loading = false;
  bool noMore = false;
  List<Products> listProduct = [];
  int currentPage = 0;

  bool _scrollListener(ScrollNotification scrollInfo) {
    // print("${scrollInfo.metrics.pixels}");
    if (noMore == false &&
        loading == false &&
        scrollInfo.metrics.axis == Axis.vertical &&
        scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent > 0.8) {
      loadMore();
    }
    return true;
  }

  Future<SearchResult> fetchMoreResult(int page) async {
    final filter = SearchQuery("all", page, 24, "default");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await post(
      Uri.parse('${host}/beer/getall'),
      body: jsonEncode(filter),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // print(response.body);
      return SearchResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void loadMore() {
    loading = true;
    setState(() {});
    currentPage;
    fetchMoreResult(currentPage).then((value) {
      List<Products> moreProduct = value.result;
      noMore = moreProduct.isEmpty;
      listProduct.addAll(moreProduct);
      loading = false;
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BootStrap>(
      future: widget.futureBootstrap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return mainContent(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Column mainContent(BootStrap data) {
    listProduct = data.products;
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Carousel(
                        data: data.carousel,
                      ),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          height: 0.1,
                          width: 0.1,
                          child: OverflowBox(
                            maxWidth: 300,
                            maxHeight: 100,
                            minWidth: 0,
                            minHeight: 0,
                            child: Transform.translate(
                              offset: const Offset(0, 15),
                              child: floatBanner(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -(50 - 50 / 2 - 15 - 0.1)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            floatBanner(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListProduct(products: listProduct),
                SliverToBoxAdapter(
                  child: loading
                      ? const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
        const SearchButton(),
      ],
    );
  }

  Container floatBanner() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 300,
      // padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondBackgroundColor,
        border: Border.all(color: normalBorderColor, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: const Text("Free ship đơn hàng trên 1 triệu!"),
    );
  }
}
