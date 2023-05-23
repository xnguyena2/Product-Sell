import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/app_state.dart';
import '../constants.dart';
import '../page/page_index.dart';

typedef SwitchPage = void Function(PageIndex);

class MainBars extends StatefulWidget {
  final SwitchPage switchPage;
  final PageIndex pageIndex;
  const MainBars({
    super.key,
    required this.switchPage,
    required this.pageIndex,
  });

  @override
  State<MainBars> createState() => MainBarsState();
}

class MainBarsState extends State<MainBars> {
  late PageIndex btnActive;

  @override
  Widget build(BuildContext context) {
    btnActive = widget.pageIndex;
    var appState = context.read<MyAppState>();
    appState.switchSearchPage = () {
      switchPage(PageIndex.search);
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        newIconBar(PageIndex.home, "assets/icons/Home.png"),
        newIconBar(PageIndex.search, "assets/icons/SearchBar.png"),
        newIconBar(PageIndex.package, "assets/icons/Package.png"),
        newIconBar(PageIndex.profile, "assets/icons/Profile.png"),
      ],
    );
  }

  switchPage(PageIndex index) {
    widget.switchPage(index);
  }

  Stack newIconBar(PageIndex index, String path) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        IconButton(
          onPressed: () {
            switchPage(index);
          },
          icon: Image.asset(
            path,
            width: 20,
          ),
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
