class Order {
  Order({
    required this.preOrder,
    required this.packageOrder,
    required this.beerOrders,
  });
  late final bool preOrder;
  late final PackageOrder packageOrder;
  late final List<BeerOrders> beerOrders;

  Order.fromJson(Map<String, dynamic> json) {
    preOrder = json['preOrder'];
    packageOrder = PackageOrder.fromJson(json['packageOrder']);
    beerOrders = List.from(json['beerOrders'])
        .map((e) => BeerOrders.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['preOrder'] = preOrder;
    _data['packageOrder'] = packageOrder.toJson();
    _data['beerOrders'] = beerOrders.map((e) => e.toJson()).toList();
    return _data;
  }
}

class PackageOrder {
  PackageOrder({
    required this.userDeviceId,
    required this.reciverAddress,
    required this.regionId,
    required this.districtId,
    required this.wardId,
    required this.reciverFullname,
    required this.phoneNumber,
    required this.totalPrice,
    required this.shipPrice,
  });
  late final String userDeviceId;
  late final String reciverAddress;
  late final int regionId;
  late final int districtId;
  late final int wardId;
  late final String reciverFullname;
  late final String phoneNumber;
  late final int totalPrice;
  late final int shipPrice;

  PackageOrder.fromJson(Map<String, dynamic> json) {
    userDeviceId = json['user_device_id'];
    reciverAddress = json['reciver_address'];
    regionId = json['region_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    reciverFullname = json['reciver_fullname'];
    phoneNumber = json['phone_number'];
    totalPrice = json['total_price'];
    shipPrice = json['ship_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_device_id'] = userDeviceId;
    _data['reciver_address'] = reciverAddress;
    _data['region_id'] = regionId;
    _data['district_id'] = districtId;
    _data['ward_id'] = wardId;
    _data['reciver_fullname'] = reciverFullname;
    _data['phone_number'] = phoneNumber;
    _data['total_price'] = totalPrice;
    _data['ship_price'] = shipPrice;
    return _data;
  }
}

class BeerOrders {
  BeerOrders({
    required this.beerOrder,
    required this.beerUnitOrders,
  });
  late final BeerOrder beerOrder;
  late final List<BeerUnitOrders> beerUnitOrders;

  BeerOrders.fromJson(Map<String, dynamic> json) {
    beerOrder = BeerOrder.fromJson(json['beerOrder']);
    beerUnitOrders = List.from(json['beerUnitOrders'])
        .map((e) => BeerUnitOrders.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['beerOrder'] = beerOrder.toJson();
    _data['beerUnitOrders'] = beerUnitOrders.map((e) => e.toJson()).toList();
    return _data;
  }
}

class BeerOrder {
  BeerOrder({
    required this.beerSecondId,
    required this.voucherSecondId,
    required this.totalPrice,
    required this.shipPrice,
  });
  late final String beerSecondId;
  late final String voucherSecondId;
  late final int totalPrice;
  late final int shipPrice;

  BeerOrder.fromJson(Map<String, dynamic> json) {
    beerSecondId = json['beer_second_id'];
    voucherSecondId = json['voucher_second_id'];
    totalPrice = json['total_price'];
    shipPrice = json['ship_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['beer_second_id'] = beerSecondId;
    _data['voucher_second_id'] = voucherSecondId;
    _data['total_price'] = totalPrice;
    _data['ship_price'] = shipPrice;
    return _data;
  }
}

class BeerUnitOrders {
  BeerUnitOrders({
    required this.beerSecondId,
    required this.beerUnitSecondId,
    required this.numberUnit,
    required this.price,
    required this.totalDiscount,
  });
  late final String beerSecondId;
  late final String beerUnitSecondId;
  late final int numberUnit;
  late final int price;
  late final int totalDiscount;

  BeerUnitOrders.fromJson(Map<String, dynamic> json) {
    beerSecondId = json['beer_second_id'];
    beerUnitSecondId = json['beer_unit_second_id'];
    numberUnit = json['number_unit'];
    price = json['price'];
    totalDiscount = json['total_discount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['beer_second_id'] = beerSecondId;
    _data['beer_unit_second_id'] = beerUnitSecondId;
    _data['number_unit'] = numberUnit;
    _data['price'] = price;
    _data['total_discount'] = totalDiscount;
    return _data;
  }
}
