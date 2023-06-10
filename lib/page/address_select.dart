import 'package:flutter/material.dart';

import '../constants.dart';
import 'component/address_item.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({super.key});

  @override
  State<AddressSelector> createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String _isRadioSelected = "address1";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
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
            )),
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Text("Địa Chi"),
                padding: EdgeInsets.all(15),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) => AddressItem(
                  label: 'This is the first label text',
                  value: "address${index}",
                  groupValue: _isRadioSelected,
                  onChanged: (String newValue) {
                    setState(() {
                      _isRadioSelected = newValue;
                    });
                  },
                  enableDivider: index < 19,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 1,
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      filterQuality: FilterQuality.high,
                      image: AssetImage("assets/icons/AddAddress.png"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Thêm Địa Chỉ Mới",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: highTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
            // SliverFillRemaining(
            //   child: ListView.separated(
            //     itemBuilder: (context, index) => AddressItem(
            //       label: 'This is the first label text',
            //       value: "address${index}",
            //       groupValue: _isRadioSelected,
            //       onChanged: (String newValue) {
            //         setState(() {
            //           _isRadioSelected = newValue;
            //         });
            //       },
            //     ),
            //     scrollDirection: Axis.vertical,
            //     itemCount: 20,
            //     separatorBuilder: (BuildContext context, int index) =>
            //         const Divider(),
            //   ),
            // ),
            // ListView.separated(
            //   itemBuilder: (context, index) => AddressItem(
            //     label: 'This is the first label text',
            //     value: "address${index}",
            //     groupValue: _isRadioSelected,
            //     onChanged: (String newValue) {
            //       setState(() {
            //         _isRadioSelected = newValue;
            //       });
            //     },
            //   ),
            //   scrollDirection: Axis.vertical,
            //   itemCount: 20,
            //   separatorBuilder: (BuildContext context, int index) =>
            //       const Divider(),
            // ),
            // TextButton(
            //   onPressed: () {},
            //   style: TextButton.styleFrom(
            //     minimumSize: Size.zero,
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     padding: const EdgeInsets.all(20),
            //   ),
            //   child: const Text(
            //     "Thêm Địa Chỉ Mới",
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       color: highTextColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
