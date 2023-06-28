import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/address_data.dart';
import 'component/app_bar.dart';
import 'location_select.dart';

class ReciverInfo extends StatelessWidget {
  final AddressData addressData;
  const ReciverInfo({
    super.key,
    required this.addressData,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleHeader("Liên hệ"),
              InputText(
                hint: "Họ và tên",
                textInputType: TextInputType.name,
                onChanged: (value) {
                  addressData.reciverFullName = value;
                },
                initialValue: addressData.reciverFullName,
              ),
              const Divider(height: 1),
              InputText(
                hint: "Số điện thoại",
                initialValue: addressData.phoneNumber,
                onChanged: (String value) {
                  addressData.phoneNumber = value;
                },
                textInputType: TextInputType.phone,
              ),
              TitleHeader("Địa chỉ"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationSelect(
                        addressData: addressData,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: secondBackgroundColor,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.all(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tỉnh/Thành phố, Quận/Huyện, Phường/Xã >",
                      style: TextStyle(
                          color: highTextColor.withOpacity(0.6), fontSize: 16),
                    ),
                    const Image(
                      image: AssetImage("assets/icons/Next.png"),
                      filterQuality: FilterQuality.high,
                      width: 20,
                    )
                  ],
                ),
              ),
              const Divider(height: 1),
              InputText(
                hint: "Tên đường, Tòa nhà, Số nhà.",
                initialValue: addressData.houseNumber,
                textInputType: TextInputType.text,
                onChanged: (String value) {
                  addressData.houseNumber = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: activeColor),
                        onPressed: () {
                          print(addressData.toJson().toString());
                        },
                        child: const Text(
                          "Hoàng Thành",
                          style: TextStyle(color: secondBackgroundColor),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container TitleHeader(String txt) {
    return Container(
      child: Text(txt),
      padding: EdgeInsets.all(15),
    );
  }
}

typedef ValueChanged = void Function(String value);

class InputText extends StatelessWidget {
  final String hint;
  final TextInputType textInputType;
  final ValueChanged onChanged;
  final String initialValue;
  const InputText(
      {super.key,
      required this.hint,
      required this.textInputType,
      required this.onChanged,
      required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: (value) => onChanged(value),
      keyboardType: textInputType,
      style: const TextStyle(
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: secondBackgroundColor,
        hoverColor: secondBackgroundColor,
        contentPadding: const EdgeInsets.all(15),
        isDense: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      inputFormatters: [],
    );
  }
}
