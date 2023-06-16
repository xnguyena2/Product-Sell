import 'package:flutter/material.dart';

import '../constants.dart';
import 'component/app_bar.dart';
import 'location_select.dart';

class ReciverInfo extends StatelessWidget {
  const ReciverInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BackAppBar(),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleHeader("Liên hệ"),
              InputText(hint: "Họ và tên"),
              Divider(height: 1),
              InputText(hint: "Số điện thoại"),
              TitleHeader("Địa chỉ"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationSelect(),
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
              Divider(height: 1),
              InputText(hint: "Tên đường, Tòa nhà, Số nhà."),
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

class InputText extends StatelessWidget {
  final String hint;
  const InputText({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: const TextStyle(
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: secondBackgroundColor,
        hoverColor: secondBackgroundColor,
        contentPadding: EdgeInsets.all(15),
        isDense: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      inputFormatters: [],
    );
  }
}
