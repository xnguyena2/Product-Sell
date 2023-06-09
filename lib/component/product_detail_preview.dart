import 'package:flutter/material.dart';
import 'package:product_sell/page/product_detail.dart';

import '../constants.dart';
import '../page/cart.dart';

class ProductDetailPreview extends StatelessWidget {
  const ProductDetailPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: secondBackgroundColor,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductDetail()),
          );
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 20,
                    // alignment: Alignment.topRight,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        // isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 0,
                                child: SizedBox(
                                  height: 20,
                                  width: 100,
                                  child: Divider(
                                      thickness: 5, color: Colors.black),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: const ProductDetail(
                                  preView: true,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Image(
                      image: AssetImage("assets/icons/FastSeen.png"),
                      filterQuality: FilterQuality.high,
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Image.asset("assets/icons/TestProduct1.png"),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nike",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: secondTextColor,
                    ),
                    "Air Force 1 Jester XX Black Sonic Yellow Air Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic Yellow"),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(text: "99", children: [
                    TextSpan(
                      text: "đ",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ]),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
