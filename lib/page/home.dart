import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      // setState(() {
                      //   currentIndex = index + 1;
                      // });
                    },
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: AspectRatio(
                              aspectRatio: 315 / 219,
                              child: Image.asset(
                                "assets/icons/TestProduct2.png",
                                // fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              ListProduct(),
            ],
          ),
        ),
        SearchButton(),
      ],
    );
  }
}
