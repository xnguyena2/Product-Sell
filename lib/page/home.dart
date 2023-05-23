import 'package:flutter/material.dart';

import '../component/list_product.dart';
import '../component/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      verticalDirection: VerticalDirection.up,
      children: [
        ListProduct(),
        SearchButton(),
      ],
    );
  }
}
