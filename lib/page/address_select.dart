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
  late ListAddressData listAddressData;
  late AddressData selectedAddress;
  late String defaultAddressKey;

  void updateListAddress() {
    var box = Hive.box(hiveSettingBox);
    box.put(hiveListAddressID, jsonEncode(listAddressData.toJson()));
  }

  void updateSelectedAddress(String key) {
    var box = Hive.box(hiveSettingBox);
    box.put(hiveDefaultAddressID, key);
  }

  @override
  void initState() {
    super.initState();

    var box = Hive.box(hiveSettingBox);
    String? dataText = box.get(hiveListAddressID);
    if (dataText != null) {
      listAddressData = ListAddressData.fromJson(jsonDecode(dataText));
    } else {
      listAddressData = ListAddressData(listAddress: <String, AddressData>{});
    }

    dataText = box.get(hiveDefaultAddressID);
    if (dataText == null || listAddressData.listAddress[dataText] == null) {
      defaultAddressKey = '';
      selectedAddress = AddressData(
          addressID: "",
          deviceID: deviceID,
          reciverFullName: "",
          phoneNumber: "",
          houseNumber: "",
          region: Region(name: "", id: -1),
          district: Region(name: "", id: -1),
          ward: Region(name: "", id: -1),
          regionTextFormat: "");
    } else {
      defaultAddressKey = dataText;
      selectedAddress = listAddressData.listAddress[dataText]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackAppBar(),
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Địa Chi"),
              ),
            ),
            ValueListenableBuilder<Box>(
              valueListenable: Hive.box(hiveSettingBox)
                  .listenable(keys: [hiveListAddressID]),
              builder: (context, box, child) {
                String? dataText = box.get(hiveListAddressID);
                if (dataText != null) {
                  listAddressData =
                      ListAddressData.fromJson(jsonDecode(dataText));
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: listAddressData.listAddress.length,
                    (context, index) {
                      String key =
                          listAddressData.listAddress.keys.elementAt(index);
                      AddressData data = listAddressData.listAddress[key]!;
                      return AddressItem(
                        label: '',
                        value: key,
                        groupValue: defaultAddressKey,
                        onChanged: (String newValue) {
                          defaultAddressKey = key;
                          selectedAddress = data;
                          updateSelectedAddress(key);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        enableDivider:
                            index < listAddressData.listAddress.length - 1,
                        addressData: data,
                        onDeleteAddress: () {
                          listAddressData.listAddress.remove(key);
                          updateListAddress();
                        },
                        onUpdateAddress: () {
                          updateListAddress();
                        },
                      );
                    },
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
                onPressed: () async {
                  AddressData addressData = AddressData(
                      addressID: "",
                      deviceID: deviceID,
                      reciverFullName: "",
                      phoneNumber: "",
                      houseNumber: "",
                      region: Region(name: "", id: -1),
                      district: Region(name: "", id: -1),
                      ward: Region(name: "", id: -1),
                      regionTextFormat: "");
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReciverInfo(
                        addressData: addressData,
                        done: () {
                          String id = generateID();
                          listAddressData.listAddress[id] = addressData;
                          updateListAddress();
                        },
                        delete: () {},
                        isEdit: false,
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
