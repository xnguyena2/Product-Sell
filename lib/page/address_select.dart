import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_sell/model/address_data.dart';
import 'package:product_sell/model/region.dart';

import '../constants.dart';
import 'component/address_item.dart';
import 'component/app_bar.dart';
import 'reciver_info.dart';

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
            ValueListenableBuilder<Box>(
              valueListenable:
                  Hive.box('settings').listenable(keys: ['listAddress']),
              builder: (context, box, child) {
                ListAddressData listAddressData =
                    ListAddressData(listAddress: []);
                String? dataText = box.get('listAddress');
                if (dataText != null) {
                  listAddressData =
                      ListAddressData.fromJson(jsonDecode(dataText));
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: listAddressData.listAddress.length,
                    (context, index) => AddressItem(
                      label: '',
                      value: '',
                      groupValue: _isRadioSelected,
                      onChanged: (String newValue) {
                        setState(() {
                          _isRadioSelected = newValue;
                        });
                      },
                      enableDivider:
                          index < listAddressData.listAddress.length - 1,
                      addressData: listAddressData.listAddress[index],
                    ),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 1,
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReciverInfo(
                        addressData: AddressData(
                            addressID: "",
                            deviceID: deviceID,
                            reciverFullName: "",
                            phoneNumber: "",
                            houseNumber: "",
                            region: Region(name: "", id: -1),
                            district: Region(name: "", id: -1),
                            ward: Region(name: "", id: -1),
                            regionTextFormat: ""),
                      ),
                    ),
                  );
                },
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
