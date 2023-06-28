import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/address_data.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.enableDivider = true,
    this.isRadio = true,
    required this.addressData,
  });

  final AddressData addressData;
  final bool enableDivider;
  final String label;
  final String groupValue;
  final String value;
  final ValueChanged<String> onChanged;

  final bool isRadio;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        } else if (!isRadio) {
          onChanged(value);
        }
      },
      child: Container(
        color: secondBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
                    !isRadio
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              label,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        : const SizedBox(),
                    Text.rich(
                      TextSpan(text: addressData.reciverFullName, children: [
                        TextSpan(
                          text: "  |  ${addressData.phoneNumber}",
                          style: const TextStyle(
                            color: secondTextColor,
                          ),
                        )
                      ]),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      addressData.houseNumber,
                      style: const TextStyle(
                        color: secondTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      addressData.regionTextFormat,
                      style: const TextStyle(
                        color: secondTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isRadio
                ? SizedBox()
                : const Image(
                    filterQuality: FilterQuality.high,
                    image: AssetImage("assets/icons/Next.png"),
                  )
          ],
        ),
      ),
    );
  }
}
