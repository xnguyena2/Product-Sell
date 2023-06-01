import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController _NumberController =
      TextEditingController(text: "1");
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
    return SafeArea(
      child: Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 19),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 19),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          backgroundColor: dartBackgroundColor,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
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
            )
          ],
        ),
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
              icon: const Image(
                image: AssetImage("assets/icons/Back.png"),
              ),
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
              icon: Image.asset("assets/icons/Package.png"),
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
                child: createPreivewImage(index),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
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
                    itemBuilder: (context, index) => createCategory(index),
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

  GestureDetector createCategory(int index) {
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
    );
  }

  GestureDetector createPreivewImage(int index) {
    var key = GlobalKey();
    return GestureDetector(
      key: key,
      onTap: () {
        scrollTo(key);
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
    );
  }

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        alignment: 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.ease);
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
              backgroundColor: Colors.white,
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
