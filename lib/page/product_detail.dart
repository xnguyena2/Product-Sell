import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:product_sell/page/cart.dart';
import 'package:product_sell/page/component/carousel.dart';
import 'package:product_sell/page/component/image_loading.dart';
import 'package:provider/provider.dart';

import '../api/post.dart';
import '../component/list_product.dart';
import '../constants.dart';
import '../global/app_state.dart';
import '../model/boostrap.dart';
import '../model/product_package.dart';
import '../model/search_query.dart';
import '../model/search_result.dart';
import '../model/user_info_query.dart';
import 'page_index.dart';

class ProductDetail extends StatefulWidget {
  final bool preView;
  final Products product;
  const ProductDetail({super.key, required this.product, this.preView = false});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late Animation _colorShowUp;
  late Animation _colorShadow, _colorBackBtn;
  final TextEditingController _NumberController =
      TextEditingController(text: "1");
  int activeImageIndex = 0;
  int activeCategoryIndex = 0;
  bool detailExpand = false;
  int currentIndex = 1;
  CarouselController buttonCarouselController = CarouselController();

  bool loading = false;
  bool noMore = false;
  final filter = SearchQuery("", 0, 24, "default");
  late Future<SearchResult> futureSearchResult;
  List<Products> listProduct = [];
  final oCcy = NumberFormat("#,##0", "en_US");

  bool processing = false;

  // add cart animation
  late final AnimationController _addCartController;
  late final Animation<double> _addCartAnimation;

  @override
  void initState() {
    super.initState();
    futureSearchResult = fetchSearchResult(filter);
    _ColorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorShowUp =
        ColorTween(begin: Colors.transparent, end: dartBackgroundColor)
            .animate(_ColorAnimationController)
          ..addListener(() {
            setState(() {
              // print(_colorShowUp.value);
            });
          });
    _colorShadow = ColorTween(
            begin: Colors.transparent, end: shadowColorDark.withOpacity(0.2))
        .animate(_ColorAnimationController);
    _colorBackBtn = ColorTween(
            begin: shadowColorDark.withOpacity(0.2), end: shadowColorDark)
        .animate(_ColorAnimationController);

    _addCartController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _addCartAnimation = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _addCartController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() => {});
      });
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical &&
        scrollInfo.metrics.pixels <= 300) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 150);
    }
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
      removeDumplicate(moreProduct);
      noMore = moreProduct.isEmpty;
      listProduct.addAll(moreProduct);
      loading = false;
      setState(() {});
    });
  }

  void removeDumplicate(List<Products> listProducts) {
    listProducts.removeWhere(
        (element) => element.beerSecondID == widget.product.beerSecondID);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _addCartController.dispose();
    _ColorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool preView = widget.preView;
    Products product = widget.product;
    double screenWidth = MediaQuery.of(context).size.width;
    var appState = context.read<MyAppState>();
    int noNotifi = appState.notificationNo[PageIndex.cart]!;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          // verticalDirection: VerticalDirection.up,
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: _scrollListener,
              child: CustomScrollView(
                slivers: [
                  productBigImage(screenWidth, product.images),
                  productDetail(product),
                  preView ? const SliverToBoxAdapter() : watchMore(),
                  preView
                      ? const SliverToBoxAdapter()
                      : FutureBuilder<SearchResult>(
                          future: futureSearchResult,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              listProduct = snapshot.data!.result;
                              removeDumplicate(listProduct);
                              return ListProduct(
                                products: listProduct,
                              );
                            } else if (snapshot.hasError) {
                              return SliverToBoxAdapter(
                                  child: Text('${snapshot.error}'));
                            }
                            // By default, show a loading spinner.
                            return const SliverToBoxAdapter(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                  preView
                      ? const SliverToBoxAdapter()
                      : SliverToBoxAdapter(
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
                  endPadding()
                ],
              ),
            ),
            preView ? SizedBox() : backBtn(context, noNotifi),
            addCart(appState),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter endPadding() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 80,
      ),
    );
  }

  SliverToBoxAdapter watchMore() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              margin: const EdgeInsets.only(right: 10),
              child: Divider(
                color: highTextColor.withOpacity(0.4),
              ),
            ),
            const Text(
              "Xem thêm",
              style: TextStyle(
                color: highTextColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(left: 10),
              child: Divider(
                color: highTextColor.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned addCart(MyAppState appState) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: secondBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: normalBorderColor,
            ),
          ],
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: normalBorderColor,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: secondBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        String value = _NumberController.text;
                        if (value.isEmpty) {
                          return;
                        }
                        int currentNum = int.parse(value);
                        currentNum--;
                        if (currentNum < 1) {
                          return;
                        }
                        _NumberController.text = currentNum.toString();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                      ),
                      child: const Text(
                        "-",
                        style: TextStyle(
                          color: dartBackgroundColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _NumberController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          print(value);
                        },
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[0-9]"),
                          ),
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              String value = newValue.text;
                              if (value.isEmpty) {
                                return newValue.copyWith(
                                  text: "1",
                                );
                              }
                              int intValue = int.parse(value);
                              if (intValue < 1) {
                                intValue = 1;
                              }
                              return newValue.copyWith(
                                text: intValue.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String value = _NumberController.text;
                        if (value.isEmpty) {
                          return;
                        }
                        int currentNum = int.parse(value);
                        currentNum++;
                        _NumberController.text = currentNum.toString();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                      ),
                      child: const Text(
                        "+",
                        style: TextStyle(
                          color: dartBackgroundColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: processing
                    ? null
                    : () {
                        ListUnit currentUnit =
                            widget.product.listUnit[activeCategoryIndex];
                        changePackage(
                          currentUnit,
                          int.parse(_NumberController.text),
                          () {
                            fetchPackageResultAgain(appState);
                            updatePackageAnimation();
                          },
                        );
                      },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  backgroundColor:
                      processing ? normalBorderColor05 : dartBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                child: const Image(
                  width: 30,
                  filterQuality: FilterQuality.high,
                  image: AssetImage("assets/icons/AddPackageWhite.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePackage(ListUnit unit, int numberUnit, VoidCallback refresh) {
    setState(() {
      processing = true;
    });
    addToPackage(
      ProductPackage(
          beerID: widget.product.beerSecondID,
          beerUnits: [
            BeerUnits(beerUnitID: unit.beerUnitSecondId, numberUnit: numberUnit)
          ],
          deviceID: deviceID),
    ).then((value) {
      setState(() {
        processing = false;
      });
      refresh();
    }).catchError(
      (error, stackTrace) {
        setState(() {
          processing = false;
        });
        print("Error: $error");
      },
    );
  }

  void updatePackageAnimation() async {
    await _addCartController.forward();
    await _addCartController.reverse();
  }

  void fetchPackageResultAgain(MyAppState appState) {
    var futurePackage = fetchPackageResult(UserInfoQuery(0, 0, deviceID));
    appState.setPackageResult(futurePackage);
    futurePackage.then((value) => Future.delayed(Duration(milliseconds: 200))
        .then((value) => setState(() {})));
  }

  Container backBtn(BuildContext context, int noNotifi) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: _colorShowUp.value,
        boxShadow: [
          BoxShadow(
            color: _colorShadow.value,
            offset: const Offset(
              0.0,
              4.0,
            ),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            // padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: _colorBackBtn.value,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: IconButton(
              icon: const Image(
                image: AssetImage("assets/icons/Back.png"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Transform.scale(
            scale: _addCartAnimation.value,
            child: Container(
              height: 40,
              width: 40,
              // padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: _colorBackBtn.value,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  IconButton(
                    icon: Image.asset("assets/icons/Package.png"),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Cart(
                                  buyItem: null,
                                )),
                      );
                      setState(() {});
                    },
                  ),
                  noNotifi > 0
                      ? Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: secondBackgroundColor,
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: activeColor,
                              child: Text(
                                "$noNotifi",
                                style: const TextStyle(
                                  color: secondBackgroundColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter productDetail(Products product) {
    ListUnit currentUnit = product.listUnit[activeCategoryIndex];
    List<String> listPreviewImage =
        product.images?.map((e) => e.thumbnail).toList() ?? [];
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            height: 80,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 1 / 1,
                child: createPreivewImage(listPreviewImage[index], index),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: listPreviewImage.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.name}",
                      style: const TextStyle(
                        color: highTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: oCcy.format(
                              currentUnit.price *
                                  (1 - currentUnit.discount / 100),
                            ),
                            children: const [
                              TextSpan(
                                text: "đ",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                          style: const TextStyle(
                            color: highTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        currentUnit.discount > 0
                            ? const SizedBox(
                                width: 10,
                              )
                            : const SizedBox(),
                        currentUnit.discount > 0
                            ? Text.rich(
                                TextSpan(
                                  text: oCcy.format(currentUnit.price),
                                  children: const [
                                    TextSpan(
                                      text: "đ",
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    )
                                  ],
                                ),
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: secondTextColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(color: normalBorderColor),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Text(
                      "Loại",
                      style: TextStyle(
                        color: highTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  height: 50,
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        createCategory(product.listUnit[index], index),
                    scrollDirection: Axis.horizontal,
                    itemCount: product.listUnit.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(color: normalBorderColor),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Text(
                      "Chi Tiết:",
                      style: TextStyle(
                        color: highTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(color: normalBorderColor),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      detailExpand = !detailExpand;
                    });
                  },
                  child: Text(
                    maxLines: detailExpand ? null : 3,
                    overflow: detailExpand ? null : TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: highTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    "${product.detail}",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector createCategory(ListUnit unit, int index) {
    var key = GlobalKey();
    return GestureDetector(
      key: key,
      onTap: () {
        scrollTo(key);
        setState(() {
          activeCategoryIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: activeCategoryIndex == index
              ? highTextColor
              : secondBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: activeCategoryIndex == index
                ? dartBackgroundColor
                : normalBorderColor,
          ),
        ),
        child: Text(
          "${unit.name}",
          style: TextStyle(
            color: activeCategoryIndex == index
                ? secondBackgroundColor
                : highTextColor,
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  GestureDetector createPreivewImage(String url, int index) {
    var key = GlobalKey();
    return GestureDetector(
      key: key,
      onTap: () {
        scrollTo(key);
        setState(() {
          activeImageIndex = index;
          buttonCarouselController.animateToPage(activeImageIndex);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: activeImageIndex == index
                ? dartBackgroundColor
                : normalBorderColor,
          ),
          boxShadow: [
            activeImageIndex == index
                ? BoxShadow(
                    color: shadowColorDark.withOpacity(0.3),
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  )
                : const BoxShadow(),
          ],
        ),
        child: ImageLoading(url: url),
      ),
    );
  }

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        alignment: 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.ease);
  }

  SliverToBoxAdapter productBigImage(
      double screenWidth, List<Images>? carousel) {
    carousel ??= [Images.error()];
    List<String> images = carousel
        .map(
          (e) => e.large,
        )
        .toList();
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Positioned(
            top: 50 - screenWidth,
            left: screenWidth / 2 - screenWidth / 1.5,
            child: CircleAvatar(
              radius: screenWidth / 1.5,
              backgroundColor: Colors.white,
            ),
          ),
          Carousel(
            data: images,
            mainCarousel: false,
            carouselController: buttonCarouselController,
            pageChange: (index) {
              setState(() {
                activeImageIndex = index;
              });
            },
          )
        ],
      ),
    );
  }
}
