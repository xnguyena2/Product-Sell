import 'package:flutter/material.dart';

import '../../constants.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.enableDivider = true,
  });

  final bool enableDivider;
  final String label;
  final String groupValue;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        color: secondBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: <Widget>[
            Radio<String>(
              groupValue: groupValue,
              value: value,
              onChanged: (String? newValue) {
                onChanged(newValue!);
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: enableDivider
                    ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: shadowColor,
                          ),
                        ),
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(text: "Nguyễn Phong", children: [
                        TextSpan(
                          text: "  |  0794566255",
                          style: TextStyle(
                            color: secondTextColor,
                          ),
                        )
                      ]),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Đài Truyền Thanh Duy Xuyên Gần Cầu Chìm",
                      style: TextStyle(
                        color: secondTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Xã Duy Trung, Huyện Duy Xuyên, Quảng Nam",
                      style: TextStyle(
                        color: secondTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
