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
    appState.refreshMainBar = () {
      setState(() {});
    };

    var notifiMap = appState.notificationNo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        newIconBar(PageIndex.home, "assets/icons/Home.png", notifiMap),
        newIconBar(PageIndex.search, "assets/icons/SearchBar.png", notifiMap),
        newIconBar(PageIndex.cart, "assets/icons/Package.png", notifiMap),
        newIconBar(PageIndex.profile, "assets/icons/Profile.png", notifiMap),
      ],
    );
  }

  switchPage(PageIndex index) {
    widget.switchPage(index);
  }

  Stack newIconBar(
      PageIndex index, String path, Map<PageIndex, int> notifiMap) {
    int noNotifi = notifiMap[index]!;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        IconButton(
          iconSize: 30,
          onPressed: () {
            switchPage(index);
          },
          icon: Image(
            filterQuality: FilterQuality.high,
            image: AssetImage(path),
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
        noNotifi > 0
            ? Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: secondBackgroundColor,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: activeColor,
                    child: Text(
                      "$noNotifi",
                      style: TextStyle(
                        color: secondBackgroundColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
