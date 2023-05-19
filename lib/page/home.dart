import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/app_state.dart';
import '../component/list_product.dart';
import '../component/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        const ListProduct(),
        SearchButton(
          searchPress: () {
            var appState = context.read<MyAppState>();
            appState.switchSearchPage?.call();
          },
        ),
      ],
    );
  }
}
