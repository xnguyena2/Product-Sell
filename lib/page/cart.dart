import 'package:flutter/material.dart';

import '../constants.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: secondBackgroundColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: normalBorderColor,
              ),
            ],
            border: Border(
              top: BorderSide(
                width: 1.0,
                color: normalBorderColor,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shadowColor: Colors.transparent,
              backgroundColor: dartBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
            child: const Text(
              "Check Out",
              style: TextStyle(
                  color: secondBackgroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, bottom: 0.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      // padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            width: 1, color: shadowColor.withOpacity(0.15)),
                      ),
                      child: IconButton(
                        icon: const Image(
                          image: AssetImage("assets/icons/BackBlack.png"),
                          opacity: AlwaysStoppedAnimation(.5),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Shopping Cart",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "2 items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: dartBackgroundColor,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => BuyItem(),
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyItem extends StatelessWidget {
  const BuyItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 100 / 100,
              child: Image.asset("assets/icons/TestProduct1.png"),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Leather Chair",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Colour: Brown | Item #123456",
                        style: TextStyle(
                          color: secondTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$1000",
                        style: TextStyle(
                          color: highTextColor.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: normalBorderColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: highTextColor,
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints.tightFor(width: 30),
                              child: Text(
                                "1",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: highTextColor,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: const EdgeInsets.all(10),
                              ),
                              child: const Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: highTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
