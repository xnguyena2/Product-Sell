import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../component/list_product.dart';
import '../component/search_bar.dart';
import '../model/boostrap.dart';

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
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      // setState(() {
                      //   currentIndex = index + 1;
                      // });
                    },
                  ),
                  items: data.carousel.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: AspectRatio(
                              aspectRatio: 315 / 219,
                              child: Image.network(
                                '${url}',
                                // filterQuality: FilterQuality.high,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  print("still loading");
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Text("Error!"));
                                },
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
