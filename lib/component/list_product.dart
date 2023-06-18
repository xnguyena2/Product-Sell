import 'package:flutter/material.dart';

import '../model/boostrap.dart';
import 'product_detail_preview.dart';

class ListProduct extends StatelessWidget {
  final List<Products> products;
  const ListProduct({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          maxCrossAxisExtent: 200,
          childAspectRatio: 160 / 215,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductDetailPreview(product: this.products[index]);
          },
          childCount: this.products.length,
        ),
      ),
    );
  }
}
