import 'dart:math';

import 'package:flutter/material.dart';
import 'package:product_sell/utils/vntone.dart';

import '../api/post.dart';
import '../component/list_product.dart';
import '../constants.dart';
import '../model/boostrap.dart';
import '../model/search_query.dart';
import '../model/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _SearchTxtController = TextEditingController();

  final List<String> filterTitles = [
    "Nổi Bật",
    "Mới Nhất",
    "Bán Chạy",
    "Giá Tăng",
    "Giá Giảm",
  ];

  final Map<String, String> filterQuery = {
    "Nổi Bật": 'default',
    "Mới Nhất": 'create_asc',
    "Bán Chạy": 'sold_num',
    "Giá Tăng": 'price_asc',
    "Giá Giảm": 'price_desc',
  };
  final int priceAscIndex = 3;
  int filterQueryIndex = 0;

  int currentFilterIndex = 0;

  bool loading = false;
  bool noMore = false;
  bool searchPressed = false;
  final filter = SearchQuery("", 0, 24, "default");
  Future<SearchResult>? futureSearchResult;
  List<Products> listProduct = [];

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (noMore == false &&
        loading == false &&
        scrollInfo.metrics.axis == Axis.vertical &&
        scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent > 0.8) {
      loadMore();
    }
    return true;
  }

  void loadMore() {
    loading = true;
    setState(() {});
    filter.page++;
    fetchSearchResult(filter).then((value) {
      List<Products> moreProduct = value.result;
      noMore = moreProduct.isEmpty;
      listProduct.addAll(moreProduct);
      loading = false;
      setState(() {});
    });
  }

  void resetFilter() {
    filterQueryIndex = currentFilterIndex = 0;
  }

  void search(String txt) {
    noMore = false;
    searchPressed = true;
    String filterTitle =
        filterQuery[filterTitles[filterQueryIndex]] ?? 'default';
    filter.query = txt;
    filter.page = 0;
    filter.size = 24;
    filter.filter = filterTitle;
    futureSearchResult = fetchSearchResult(filter);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchBar(),
        searchPressed ? SizedBox() : recommend(),
        searchPressed == false
            ? SizedBox()
            : Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: _scrollListener,
                  child: CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverAppBarDelegate(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                          child: ColoredBox(
                            color: backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                filterItem(0),
                                filterSeperator(),
                                filterItem(1),
                                filterSeperator(),
                                filterItem(2),
                                filterSeperator(),
                                filterItem(3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<SearchResult>(
                        future: futureSearchResult,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const SliverToBoxAdapter(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            listProduct = snapshot.data!.result;
                            if (snapshot.data!.count == 0) {
                              noMore = true;
                              return const SliverToBoxAdapter(
                                child: Center(
                                  child: Text("Không tìm thấy kết quả!"),
                                ),
                              );
                            }
                            return ListProduct(
                              products: listProduct,
                            );
                          } else if (snapshot.hasError) {
                            return SliverToBoxAdapter(
                                child: Text('${snapshot.error}'));
                          }
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
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
      ],
    );
  }

  SizedBox filterSeperator() {
    return const SizedBox(
      height: 10,
      child: VerticalDivider(
        color: Colors.black,
        width: 1,
      ),
    );
  }

  Expanded filterItem(int index) {
    String txt =
        index == priceAscIndex && (filterQueryIndex == priceAscIndex + 1)
            ? filterTitles[filterQueryIndex]
            : filterTitles[index];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentFilterIndex = index;
          if (currentFilterIndex == priceAscIndex) {
            if (filterQueryIndex == priceAscIndex) {
              filterQueryIndex = priceAscIndex + 1;
            } else {
              filterQueryIndex = priceAscIndex;
            }
          }
          String txt = _SearchTxtController.text;
          search(txt);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: currentFilterIndex == index
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: activeColor, width: 2),
                  ),
                )
              : null,
          child: Text(
            textAlign: TextAlign.center,
            txt,
            style: TextStyle(
                color: currentFilterIndex == index
                    ? activeColor
                    : secondTextColor),
          ),
        ),
      ),
    );
  }

  Container recommend() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.center,
        children:
            ["beer", "tiger", "huda hue", "dasdf", "ad we fe"].map((item) {
          if (item.length > 15) {
            return "${item.substring(0, 15)}...";
          } else {
            return item;
          }
        }).map((txt) {
          return FittedBox(
            child: GestureDetector(
              onTap: () {
                _SearchTxtController.text = txt;
                resetFilter();
                search(txt);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //   color: dartBackgroundColor,
                  // ),
                ),
                child: Text(
                  "$txt",
                  style: const TextStyle(
                    color: dartBackgroundColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Container searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColorDark.withOpacity(0.1),
            offset: const Offset(
              0.0,
              2.0,
            ),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 20),
        decoration: const BoxDecoration(
          color: secondBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                String txt = _SearchTxtController.text;
                resetFilter();
                search(txt);
              },
              child: Image.asset("assets/icons/Search.png"),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                autofocus: true,
                controller: _SearchTxtController,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                decoration: const InputDecoration(
                  hintText: "Search Product",
                  hintStyle: TextStyle(
                    color: secondTextColor,
                    fontSize: 16,
                  ),
                  contentPadding: EdgeInsets.all(0),
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double? minHeight;
  final double? maxHeight;
  final Widget? child;

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => max(maxHeight!, minHeight!);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
