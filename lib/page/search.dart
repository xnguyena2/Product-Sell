import 'package:flutter/material.dart';

import '../constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _SearchTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
          child: Container(
            height: 40,
            padding: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
              color: secondBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset("assets/icons/Search.png"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: _SearchTxtController,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Search Product",
                      hintStyle: TextStyle(
                        color: secondTextColor,
                        fontSize: 16,
                      ),
                      contentPadding: EdgeInsets.all(0),
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            alignment: WrapAlignment.center,
            children: [
              "loai 1",
              "biaaasdf awerff",
              "asdf ehadjswf aeswfrha df",
              "dasdf",
              "ad we fe"
            ].map((item) {
              if (item.length > 15) {
                return "${item.substring(0, 15)}...";
              } else {
                return item;
              }
            }).map((index) {
              return FittedBox(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: dartBackgroundColor,
                      // ),
                    ),
                    child: Text(
                      "$index",
                      style: const TextStyle(
                        color: dartBackgroundColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
