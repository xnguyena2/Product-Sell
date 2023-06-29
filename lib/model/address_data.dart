import 'package:product_sell/model/region.dart';

class ListAddressData {
  ListAddressData({
    required this.listAddress,
  });

  late final Map<String, AddressData> listAddress;

  ListAddressData.fromJson(Map<String, dynamic> json) {
    listAddress = Map.from(json['list_address']).map((key, value) =>
        MapEntry<String, AddressData>(key, AddressData.fromJson(value)));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['list_address'] = listAddress;
    return _data;
  }
}

class AddressData {
  late final String addressID;
  late final String deviceID;
  late String reciverFullName;
  late String phoneNumber;
  late String houseNumber;
  late Region region;
  late Region district;
  late Region ward;
  late String regionTextFormat;

  AddressData({
    required this.addressID,
    required this.deviceID,
    required this.reciverFullName,
    required this.phoneNumber,
    required this.houseNumber,
    required this.region,
    required this.district,
    required this.ward,
    required this.regionTextFormat,
  });

  AddressData.fromJson(Map<String, dynamic> json) {
    addressID = json['address_id'];
    deviceID = json['device_id'];
    reciverFullName = json['reciver_fullname'];
    phoneNumber = json['phone_number'];
    houseNumber = json['house_number'];
    region = Region.fromJson(json['region']);
    district = Region.fromJson(json['district']);
    ward = Region.fromJson(json['ward']);
    regionTextFormat = json['region_text_format'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address_id'] = addressID;
    _data['device_id'] = deviceID;
    _data['reciver_fullname'] = reciverFullName;
    _data['phone_number'] = phoneNumber;
    _data['house_number'] = houseNumber;
    _data['region'] = region;
    _data['district'] = district;
    _data['ward'] = ward;
    _data['region_text_format'] = regionTextFormat;
    return _data;
  }
}
