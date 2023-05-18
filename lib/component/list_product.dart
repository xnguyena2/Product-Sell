import 'package:flutter/material.dart';

import 'product_detail_preview.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          maxCrossAxisExtent: 400,
          childAspectRatio: 160 / 215,
        ),
        children: [
          for (var i = 0; i <= 100; i++) const ProductDetailPreview(),
        ],
      ),
    );
  }
}
