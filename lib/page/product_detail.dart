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
  late Animation _colorShadown, _colorBackBtn;

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
    _colorShadown = ColorTween(
            begin: Colors.transparent, end: shadowColorDark.withOpacity(0.2))
        .animate(_ColorAnimationController);
    _colorBackBtn = ColorTween(
            begin: shadowColorDark.withOpacity(0.4), end: shadowColorDark)
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
    return Scaffold(
      body: Stack(
        // verticalDirection: VerticalDirection.up,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: GridView(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                maxCrossAxisExtent: 200,
                childAspectRatio: 160 / 215,
              ),
              children: [
                for (var i = 0; i <= 100; i++) const ProductDetailPreview(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: _colorShowUp.value,
              boxShadow: [
                BoxShadow(
                  color: _colorShadown.value,
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
              children: [
                Container(
                  height: 40,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
