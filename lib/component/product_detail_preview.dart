import 'package:flutter/material.dart';
import 'package:product_sell/page/component/image_loading.dart';
import 'package:product_sell/page/product_detail.dart';

import '../constants.dart';
import '../model/boostrap.dart';

class ProductDetailPreview extends StatelessWidget {
  final Products product;

  const ProductDetailPreview({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    String productImageUrl = product.images?[0].large ?? "error";
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
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                product: product,
              ),
            ),
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
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              const Positioned(
                                top: 0,
                                child: SizedBox(
                                  height: 20,
                                  width: 100,
                                  child: Divider(
                                      thickness: 5, color: Colors.black),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: ProductDetail(
                                  product: product,
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
              child: ImageLoading(url: productImageUrl),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product.name}",
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
                    "${product.detail}"),
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
