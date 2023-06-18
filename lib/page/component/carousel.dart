import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'image_loading.dart';

typedef void PageChange(int index);

class Carousel extends StatefulWidget {
  final List<String> data;
  final bool mainCarousel;
  final PageChange? pageChange;
  final CarouselController? carouselController;
  const Carousel(
      {super.key,
      required this.data,
      this.mainCarousel = true,
      this.pageChange,
      this.carouselController});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentIndex = 0;
  late List<Image> cachImage;

  @override
  void initState() {
    super.initState();
    List<String> listImage = widget.data;
    cachImage = listImage.map((url) => Image.network(url)).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cachImage.forEach((element) => precacheImage(element.image, context));
  }

  @override
  Widget build(BuildContext context) {
    List<String> listImage = widget.data;
    PageChange? pageChange = widget.pageChange;
    final CarouselController? carouselController = widget.carouselController;

    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlay: widget.mainCarousel,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              pageChange?.call(index);
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: listImage.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: AspectRatio(
                      aspectRatio: 315 / 219,
                      child: ImageLoading(
                        url: url,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        widget.mainCarousel
            ? Positioned(
                left: 0,
                right: 0,
                bottom: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listImage
                      .mapIndexed(
                        (i, e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: CircleAvatar(
                              radius: 4,
                              backgroundColor: currentIndex == i
                                  ? activeColor08
                                  : normalBorderColor08),
                        ),
                      )
                      .toList(),
                ),
              )
            : Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.7),
                    border: Border.all(
                        width: 1, color: shadowColor.withOpacity(0.3)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text("${currentIndex + 1}/${listImage.length}"),
                ),
              ),
      ],
    );
  }
}
