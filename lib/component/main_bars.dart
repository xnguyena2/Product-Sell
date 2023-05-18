import 'package:flutter/material.dart';

import '../constants.dart';

class MainBars extends StatefulWidget {
  const MainBars({
    super.key,
  });

  @override
  State<MainBars> createState() => _MainBarsState();
}

class _MainBarsState extends State<MainBars> {
  int btnActive = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        newIconBar(0, "assets/icons/Home.png"),
        newIconBar(1, "assets/icons/Category.png"),
        newIconBar(2, "assets/icons/Package.png"),
        newIconBar(3, "assets/icons/Profile.png"),
      ],
    );
  }

  Stack newIconBar(int index, String path) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              btnActive = index;
            });
          },
          icon: Image.asset(path),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceOut,
          child: Container(
            // margin: const EdgeInsets.only(top: 3),
            width: btnActive == index ? 15 : 0,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: highlightColor.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
