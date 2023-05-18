import 'package:flutter/material.dart';

import '../constants.dart';

class ProductDetailPreview extends StatelessWidget {
  const ProductDetailPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: secondBackgroundColor,
      ),
      child: GestureDetector(
        onTap: () {
          print("preview click!");
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    print("add click!");
                  },
                  icon: Image.asset("assets/icons/AddPackage.png"),
                ),
              ],
            ),
            Expanded(
              child: Image.asset("assets/icons/TestProduct1.png"),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nike",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: secondTextColor,
                    ),
                    "Air Force 1 Jester XX Black Sonic Yellow Air Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic YellowAir Force 1 Jester XX Black Sonic Yellow"),
                SizedBox(height: 10),
                Text(
                  "\$99",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
