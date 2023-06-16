import 'package:flutter/material.dart';

import '../constants.dart';
import 'component/address_item.dart';
import 'component/app_bar.dart';

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
        appBar: BackAppBar(),
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
          ],
        ),
      ),
    );
  }
}
