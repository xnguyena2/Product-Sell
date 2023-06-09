import 'package:flutter/material.dart';

import 'product_detail_preview.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({
    super.key,
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
            return const ProductDetailPreview();
          },
          childCount: 100,
        ),
      ),
    );
  }
}
