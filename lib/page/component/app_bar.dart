import 'package:flutter/material.dart';

import '../../constants.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: const BoxDecoration(
        color: dartBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(
              0.0,
              1.0,
            ),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            // padding: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
              color: dartBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: IconButton(
              icon: const Image(
                image: AssetImage("assets/icons/Back.png"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
