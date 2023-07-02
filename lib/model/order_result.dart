class OrderResult {
  OrderResult({
    required this.packageOrderSecondId,
    required this.userDeviceId,
    required this.reciverAddress,
    required this.regionId,
    required this.districtId,
    required this.wardId,
    required this.reciverFullname,
    required this.phoneNumber,
    required this.phoneNumberClean,
    required this.totalPrice,
    required this.realPrice,
    required this.shipPrice,
    required this.status,
    required this.createat,
    this.id,
  });
  late final String packageOrderSecondId;
  late final String userDeviceId;
  late final String reciverAddress;
  late final int regionId;
  late final int districtId;
  late final int wardId;
  late final String reciverFullname;
  late final String phoneNumber;
  late final String phoneNumberClean;
  late final double totalPrice;
  late final double realPrice;
  late final double shipPrice;
  late final String status;
  late final String createat;
  late final Null id;

  OrderResult.fromJson(Map<String, dynamic> json) {
    packageOrderSecondId = json['package_order_second_id'];
    userDeviceId = json['user_device_id'];
    reciverAddress = json['reciver_address'];
    regionId = json['region_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    reciverFullname = json['reciver_fullname'];
    phoneNumber = json['phone_number'];
    phoneNumberClean = json['phone_number_clean'];
    totalPrice = json['total_price'];
    realPrice = json['real_price'];
    shipPrice = json['ship_price'];
    status = json['status'];
    createat = json['createat'];
    id = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['package_order_second_id'] = packageOrderSecondId;
    _data['user_device_id'] = userDeviceId;
    _data['reciver_address'] = reciverAddress;
    _data['region_id'] = regionId;
    _data['district_id'] = districtId;
    _data['ward_id'] = wardId;
    _data['reciver_fullname'] = reciverFullname;
    _data['phone_number'] = phoneNumber;
    _data['phone_number_clean'] = phoneNumberClean;
    _data['total_price'] = totalPrice;
    _data['real_price'] = realPrice;
    _data['ship_price'] = shipPrice;
    _data['status'] = status;
    _data['createat'] = createat;
    _data['id'] = id;
    return _data;
  }
}
