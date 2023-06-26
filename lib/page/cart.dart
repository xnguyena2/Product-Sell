import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_sell/api/post.dart';
import 'package:product_sell/model/boostrap.dart';
import 'package:product_sell/page/component/image_loading.dart';
import 'package:product_sell/page/page_index.dart';
import 'package:provider/provider.dart';

import '../api/get.dart';
import '../constants.dart';
import '../global/app_state.dart';
import '../model/package_result.dart';
import '../model/product_package.dart';
import 'address_select.dart';
import 'component/address_item.dart';
import 'product_detail.dart';

class Cart extends StatefulWidget {
  final PackageResult? buyPackage;
  const Cart({super.key, required this.buyPackage});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final oCcy = NumberFormat("#,##0", "en_US");
  final PackageResult buyPackage = PackageResult(listResult: []);
  late bool isCheckOut;

  @override
  void initState() {
    super.initState();
    isCheckOut = widget.buyPackage != null;
    if (isCheckOut) {
      buyPackage.listResult.addAll(widget.buyPackage!.listResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.read<MyAppState>();
    return SafeArea(
      child: FutureBuilder<PackageResult>(
        future: isCheckOut
            ? Future<PackageResult>.value(buyPackage)
            : appState.futurePackage,
        builder: (context, snapshot) {
          PackageResult? package;
          if (snapshot.hasData) {
            package = snapshot.data;
          }
          return Scaffold(
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
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "Tổng Tiền:",
                          style: TextStyle(
                            color: highTextColor.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text.rich(
                          TextSpan(
                              text: oCcy.format(buyPackage.totalPrice()),
                              style: TextStyle(
                                color: highTextColor.withOpacity(1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: const [
                                TextSpan(
                                  text: "đ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: package != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cart(
                                          buyPackage: buyPackage,
                                        )),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                        backgroundColor: dartBackgroundColor,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      child: Text(
                        isCheckOut ? "Buy" : "Check Out",
                        style: const TextStyle(
                            color: secondBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18.0, bottom: 0.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        isCheckOut ? "Check Out" : "Shopping Cart",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isCheckOut
                      ? AddressItem(
                          groupValue: '',
                          label: 'Địa Chỉ Nhận Hàng',
                          onChanged: (String value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressSelector(),
                              ),
                            );
                          },
                          value: '',
                          enableDivider: false,
                          isRadio: false,
                        )
                      : Text(
                          '${package == null ? 0 : package.calcTotal()} items',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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
                  package == null
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => BuyItem(
                              item: package!.listResult[index],
                              oCcy: oCcy,
                              refresh: () {
                                setState(() {});
                                appState.updateNotification(
                                    PageIndex.cart, package!.calcTotal());
                              },
                              delete: () => package!.listResult.removeAt(index),
                              value: isCheckOut ? null : false,
                              onChanged: (bool value) {
                                if (value) {
                                  buyPackage.listResult
                                      .add(package!.listResult[index]);
                                } else {
                                  buyPackage.listResult
                                      .remove(package!.listResult[index]);
                                }
                                setState(() {});
                              },
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: package.listResult.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuyItem extends StatefulWidget {
  final NumberFormat oCcy;
  final ListResult item;
  final VoidCallback refresh;
  final VoidCallback delete;
  final bool? value;
  final ValueChanged<bool> onChanged;
  const BuyItem({
    super.key,
    required this.item,
    required this.oCcy,
    required this.refresh,
    required this.delete,
    required this.value,
    required this.onChanged,
  });

  @override
  State<BuyItem> createState() => _BuyItemState();
}

class _BuyItemState extends State<BuyItem> {
  late bool _isSelected = widget.value ?? false;
  late bool isEnableSelectBox = widget.value != null;
  bool processing = false;
  Future<Products>? productFuture;
  @override
  Widget build(BuildContext context) {
    ListUnit unit = widget.item.beerSubmitData.listUnit[0];
    double realPrice = unit.price * (1 - unit.discount / 100);
    return GestureDetector(
      onTap: isEnableSelectBox
          ? () {
              productFuture = fetchProduct(widget.item.beerId);
              productFuture!.then(
                (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        product: value,
                      ),
                    ),
                  );
                },
              );
              setState(() {});
            }
          : null,
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  isEnableSelectBox
                      ? Checkbox(
                          value: _isSelected,
                          onChanged: (bool? newValue) {
                            _isSelected = newValue ?? false;
                            widget.onChanged(newValue!);
                          },
                        )
                      : SizedBox(),
                  isEnableSelectBox
                      ? const SizedBox(
                          width: 5,
                        )
                      : SizedBox(),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 100 / 100,
                      child: ImageLoading(
                        url: widget.item.beerSubmitData.images?[0].medium ??
                            "error",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.beerSubmitData.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Loại: ${unit.name} | ${widget.oCcy.format(realPrice)}đ",
                              style: const TextStyle(
                                color: secondTextColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: widget.oCcy
                                    .format(widget.item.numberUnit * realPrice),
                                children: const [
                                  TextSpan(
                                    text: "đ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
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
                                  isEnableSelectBox
                                      ? TextButton(
                                          onPressed: processing
                                              ? null
                                              : () {
                                                  bool isGreatThan1 =
                                                      widget.item.numberUnit >
                                                          1;
                                                  isGreatThan1
                                                      ? changePackage(unit, -1)
                                                      : showDeleteDialog(
                                                          context,
                                                          () =>
                                                              removeItem(unit),
                                                        );
                                                },
                                          style: TextButton.styleFrom(
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
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
                                        )
                                      : const SizedBox(),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints.tightFor(
                                        width: 30),
                                    child: Text(
                                      '${widget.item.numberUnit}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: highTextColor,
                                      ),
                                    ),
                                  ),
                                  isEnableSelectBox
                                      ? TextButton(
                                          onPressed: processing
                                              ? null
                                              : () => changePackage(unit, 1),
                                          style: TextButton.styleFrom(
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
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
                                        )
                                      : const SizedBox(),
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
            productFuture == null
                ? SizedBox()
                : FutureBuilder<Products>(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox();
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    future: productFuture,
                  )
          ],
        ),
      ),
    );
  }

  Future<String?> showDeleteDialog(BuildContext context, VoidCallback ok) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Chú Ý!'),
        content: const Text('Bạn có chắc muốn xóa sản phầm này không?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              ok();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void removeItem(ListUnit unit) {
    setState(() {
      processing = true;
    });
    deleteItemFromPackage(
      ProductPackage(
          beerID: widget.item.beerId,
          beerUnits: [
            BeerUnits(beerUnitID: unit.beerUnitSecondId, numberUnit: 0)
          ],
          deviceID: deviceID),
    ).then((value) {
      processing = false;
      widget.delete();
      widget.refresh.call();
    }).catchError(
      (error, stackTrace) {
        setState(() {
          processing = false;
        });
        print("Error: $error");
      },
    );
  }

  void changePackage(ListUnit unit, int diff) {
    setState(() {
      processing = true;
    });
    addToPackage(
      ProductPackage(
          beerID: widget.item.beerId,
          beerUnits: [
            BeerUnits(beerUnitID: unit.beerUnitSecondId, numberUnit: diff)
          ],
          deviceID: deviceID),
    ).then((value) {
      processing = false;
      widget.item.numberUnit += diff;
      widget.refresh.call();
    }).catchError(
      (error, stackTrace) {
        setState(() {
          processing = false;
        });
        print("Error: $error");
      },
    );
  }
}
