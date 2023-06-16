import 'package:flutter/material.dart';

import '../constants.dart';
import 'component/app_bar.dart';

class LocationSelect extends StatefulWidget {
  const LocationSelect({super.key});

  @override
  State<LocationSelect> createState() => _LocationSelectState();
}

class _LocationSelectState extends State<LocationSelect> {
  final double heighDistance = 70;
  String currentLocation = "";
  double boxSize = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BackAppBar(),
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                locationTree(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 20),
                  child: Column(
                    children: [
                      // Expanded(child: Container()),
                      SizedBox(
                        height: 5,
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        // curve: Curves.bounceOut,
                        child: SizedBox(
                          height: boxSize,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            width: 1,
                            color: shadowColor.withOpacity(0.15),
                          ),
                        ),
                        child: locationInfo("Quảng Nam", isActive: true),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              child: const Text(
                "Tỉnh/Thành Phố",
                style: TextStyle(color: secondTextColor, fontSize: 14),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Text(
                  "tinh $index",
                  style: TextStyle(),
                ),
                scrollDirection: Axis.vertical,
                itemCount: 40,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding locationTree() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 21,
          ),
          GestureDetector(
            child: locationInfo("Quảng Nam"),
            onTap: () {
              setState(() {
                boxSize = 0;
              });
            },
          ),
          divider(),
          GestureDetector(
            child: locationInfo("Duy Xuyên"),
            onTap: () {
              setState(() {
                boxSize = heighDistance * 1;
              });
            },
          ),
          divider(),
          GestureDetector(
            child: locationInfo("Duy Trung"),
            onTap: () {
              setState(() {
                boxSize = heighDistance * 2;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SizedBox divider() {
    return SizedBox(
      height: 50,
      child: VerticalDivider(
        width: 20,
        thickness: 1,
        color: secondTextColor,
      ),
    );
  }

  Row locationInfo(String date, {bool isActive = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: isActive ? activeCircle() : nromalCircle(),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          date,
          style: TextStyle(color: isActive ? activeColor : highTextColor),
        )
      ],
    );
  }

  CircleAvatar nromalCircle() {
    return CircleAvatar(
      radius: 5,
      backgroundColor: secondTextColor.withOpacity(0.5),
    );
  }

  CircleAvatar activeCircle() {
    return CircleAvatar(
      radius: 8,
      backgroundColor: activeColor,
      child: CircleAvatar(
        radius: 7,
        backgroundColor: secondBackgroundColor,
        child: CircleAvatar(
          radius: 5,
          backgroundColor: activeColor,
        ),
      ),
    );
  }
}
