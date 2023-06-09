import 'package:flutter/material.dart';
import 'package:product_sell/page/component/image_loading.dart';

import '../api/post.dart';
import '../component/list_product.dart';
import '../component/search_bar.dart';
import '../constants.dart';
import '../model/boostrap.dart';
import '../model/debug_value.dart';
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
  late Future<BootStrap> futureBootstrap;
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

  void refreshLoad() {
    noMore = false;
    currentPage = 0;
  }

  void loadMore() {
    loading = true;
    setState(() {});
    currentPage++;
    fetchMoreResult(currentPage).then((value) {
      List<Products> moreProduct = value.result;
      noMore = moreProduct.isEmpty;
      listProduct.addAll(moreProduct);
      loading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    futureBootstrap = widget.futureBootstrap;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<BootStrap>(
      future: futureBootstrap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return mainContent(snapshot.data!, screenWidth);
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

  Column mainContent(BootStrap data, double screenWidth) {
    listProduct = data.products;
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: RefreshIndicator(
              onRefresh: () {
                refreshLoad();
                futureBootstrap = fetchBootstrap();
                setState(() {});
                return futureBootstrap;
              },
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
                    child: ColoredBox(
                      color: secondBackgroundColor,
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
                          SizedBox(
                            height: 220,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 110,
                                childAspectRatio: 10 / 5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 50,
                              ),
                              itemCount: listCategory.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: secondBackgroundColor,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: normalBorderColor, width: 1),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: ImageLoading(
                                            url: listCategory[index].imageUrl),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      listCategory[index].title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 10, color: highTextColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
