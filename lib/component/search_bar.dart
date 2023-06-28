import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../global/app_state.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColorDark.withOpacity(0.1),
            offset: const Offset(
              0.0,
              2.0,
            ),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          var appState = context.read<MyAppState>();
          appState.switchSearchPage?.call();
        },
        child: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            color: secondBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/Search.png",
                filterQuality: FilterQuality.high,
              ),
              const SizedBox(width: 20),
              const Text(
                "Search Product",
                style: TextStyle(
                  color: secondTextColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
