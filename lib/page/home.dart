import 'package:flutter/material.dart';

import '../component/list_product.dart';
import '../component/search_bar.dart';
import '../model/boostrap.dart';
import 'component/carousel.dart';

class HomePage extends StatelessWidget {
  final Future<BootStrap> futureBootstrap;
  const HomePage({
    super.key,
    required this.futureBootstrap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BootStrap>(
      future: futureBootstrap,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return mainContent(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Column mainContent(BootStrap data) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Carousel(
                  data: data.carousel,
                ),
              ),
              ListProduct(products: data.products),
            ],
          ),
        ),
        SearchButton(),
      ],
    );
  }
}
