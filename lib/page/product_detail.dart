import 'dart:async';

import 'package:flutter/material.dart';

import '../component/product_detail_preview.dart';
import '../constants.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late Animation _colorShowUp;
  late Animation _colorShadow, _colorBackBtn;
  int activeImageIndex = 0;
  int activeCategoryIndex = 0;
  bool detailExpand = false;

  @override
  void initState() {
    super.initState();
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
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical &&
        scrollInfo.metrics.pixels <= 300) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 150);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        // verticalDirection: VerticalDirection.up,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: CustomScrollView(
              slivers: [
                productBigImage(screenWidth),
                productDetail(),
                listExtractProduct(),
              ],
            ),
          ),
          backBtn(context),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) {
                          // If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10));
                          }
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10));
                        },
                      ),
                      padding: MaterialStateProperty.resolveWith(
                        (states) {
                          // If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            );
                          }
                          return const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          );
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith(
                        (states) {
                          // If the button is pressed, return green, otherwise blue
                          if (states.contains(MaterialState.pressed)) {
                            return dartBackgroundColor;
                          }
                          return dartBackgroundColor;
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Mua",
                      style: TextStyle(
                        color: secondBackgroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverGrid listExtractProduct() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ProductDetailPreview();
        },
        childCount: 100,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        maxCrossAxisExtent: 200,
        childAspectRatio: 160 / 215,
      ),
    );
  }

  Container backBtn(BuildContext context) {
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
              icon: Image.asset("assets/icons/Back.png"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            height: 40,
            width: 40,
            // padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: _colorBackBtn.value,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: IconButton(
              icon: Image.asset("assets/icons/package.png"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter productDetail() {
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeImageIndex = index;
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
                    ),
                  )),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 10,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nike",
                      style: TextStyle(
                        color: highTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "\$15",
                      style: TextStyle(
                        color: highTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
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
                    "Eros, parturient sit posuere amet. Sed dignissim enim nulla egestas vitae id augue eleifend. Nam commodo scelerisque enim integer risus, non Eros, parturient sit posuere amet. Sed dignissim enim nulla egestas vitae id augue eleifend. Nam commodo scelerisque enim integer risus, nonEros, parturient sit posuere amet. Sed dignissim enim nulla egestas vitae id augue eleifend. Nam commodo scelerisque enim integer risus, non",
                  ),
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
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
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
                          "loai $index",
                          style: TextStyle(
                            color: activeCategoryIndex == index
                                ? secondBackgroundColor
                                : highTextColor,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter productBigImage(double screenWidth) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Positioned(
            top: 50 - screenWidth,
            left: screenWidth / 2 - screenWidth / 1.5,
            child: CircleAvatar(
              radius: screenWidth / 1.5,
              backgroundColor: Colors.black,
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AspectRatio(
                aspectRatio: 315 / 219,
                child: Image.asset("assets/icons/TestProduct2.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
