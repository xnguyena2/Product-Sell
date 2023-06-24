import 'package:flutter/material.dart';
import 'package:product_sell/page/component/image_loading.dart';
import 'package:product_sell/page/product_detail.dart';
import 'package:intl/intl.dart';

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
    final oCcy = NumberFormat("#,##0", "en_US");
    String productImageUrl = product.images?[0].large ?? "error";
    ListUnit minUnit = product.listUnit.reduce(
        (value, element) => value.price < element.price ? value : element);
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(15),
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
        child: Stack(
          children: [
            Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     SizedBox(
                //       width: 20,
                //       height: 20,
                //       child: IconButton(
                //         padding: const EdgeInsets.all(0.0),
                //         iconSize: 20,
                //         // alignment: Alignment.topRight,
                //         splashColor: Colors.transparent,
                //         highlightColor: Colors.transparent,
                //         hoverColor: Colors.transparent,
                //         onPressed: () {
                //           showModalBottomSheet(
                //             context: context,
                //             // isScrollControlled: true,
                //             shape: const RoundedRectangleBorder(
                //               borderRadius: BorderRadius.vertical(
                //                 top: Radius.circular(20),
                //               ),
                //             ),
                //             builder: (context) {
                //               return Stack(
                //                 alignment: Alignment.center,
                //                 children: [
                //                   const Positioned(
                //                     top: 0,
                //                     child: SizedBox(
                //                       height: 20,
                //                       width: 100,
                //                       child: Divider(
                //                           thickness: 5, color: Colors.black),
                //                     ),
                //                   ),
                //                   Container(
                //                     margin: const EdgeInsets.only(top: 20),
                //                     child: ProductDetail(
                //                       product: product,
                //                       preView: true,
                //                     ),
                //                   ),
                //                 ],
                //               );
                //             },
                //           );
                //         },
                //         icon: const Image(
                //           image: AssetImage("assets/icons/FastSeen.png"),
                //           filterQuality: FilterQuality.high,
                //           width: 20,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: ImageLoading(url: productImageUrl),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: secondTextColor,
                          ),
                          "${product.detail}"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: oCcy.format(
                                  minUnit.price * (1 - minUnit.discount / 100)),
                              children: const [
                                TextSpan(
                                  text: "đ",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: activeColor),
                          ),
                          realPrice(oCcy, minUnit),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            discountPreview(minUnit),
          ],
        ),
      ),
    );
  }

  Widget realPrice(NumberFormat formater, ListUnit minUnit) {
    return minUnit.discount > 0
        ? Text.rich(
            TextSpan(
              text: formater.format(minUnit.price),
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
        : const SizedBox();
  }

  Widget discountPreview(ListUnit minUnit) {
    return minUnit.discount > 0
        ? Positioned(
            right: 0,
            top: 0,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: activeColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: 15 / 15,
                    child: Center(
                      child: Text(
                        "${minUnit.discount}%",
                        style: const TextStyle(
                            color: secondBackgroundColor, fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0,
                  height: 0,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                      ),
                    ],
                    border: Border(
                      left: BorderSide(
                        color: activeColor,
                        width: 15.0,
                      ),
                      right: BorderSide(
                        color: activeColor,
                        width: 15.0,
                      ),
                      top: BorderSide(color: Colors.transparent, width: 10),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
