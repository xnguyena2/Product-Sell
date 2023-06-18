class BootStrap {
  BootStrap({
    required this.deviceConfig,
    required this.carousel,
    required this.products,
  });
  late final DeviceConfig deviceConfig;
  late final List<String> carousel;
  late final List<Products> products;

  BootStrap.fromJson(Map<String, dynamic> json) {
    deviceConfig = DeviceConfig.fromJson(json['deviceConfig']);
    carousel = List.castFrom<dynamic, String>(json['carousel']);
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['deviceConfig'] = deviceConfig.toJson();
    _data['carousel'] = carousel;
    _data['products'] = products.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DeviceConfig {
  DeviceConfig({
    required this.id,
    required this.color,
  });
  late final String id;
  late final String color;

  DeviceConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['color'] = color;
    return _data;
  }
}

class Products {
  Products({
    required this.beerSecondID,
    required this.name,
    this.detail,
    required this.category,
    required this.status,
    this.images,
    required this.listUnit,
  });
  late final String beerSecondID;
  late final String name;
  late final String? detail;
  late final String category;
  late final String status;
  late final List<Images>? images;
  late final List<ListUnit> listUnit;

  Products.fromJson(Map<String, dynamic> json) {
    beerSecondID = json['beerSecondID'];
    name = json['name'];
    detail = json['detail'];
    category = json['category'];
    status = json['status'];
    images = json['images'] == null
        ? null
        : List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    listUnit =
        List.from(json['listUnit']).map((e) => ListUnit.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['beerSecondID'] = beerSecondID;
    _data['name'] = name;
    _data['detail'] = detail;
    _data['category'] = category;
    _data['status'] = status;
    _data['images'] = images;
    _data['listUnit'] = listUnit.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.imgid,
    required this.thumbnail,
    required this.medium,
    required this.large,
    required this.category,
    required this.createat,
  });
  late final String id;
  late final String imgid;
  late final String thumbnail;
  late final String medium;
  late final String large;
  late final String category;
  late final String createat;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgid = json['imgid'];
    thumbnail = json['thumbnail'];
    medium = json['medium'];
    large = json['large'];
    category = json['category'];
    createat = json['createat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['imgid'] = imgid;
    _data['thumbnail'] = thumbnail;
    _data['medium'] = medium;
    _data['large'] = large;
    _data['category'] = category;
    _data['createat'] = createat;
    return _data;
  }
}

class ListUnit {
  ListUnit({
    required this.beer,
    required this.name,
    required this.price,
    required this.discount,
    this.dateExpir,
    required this.volumetric,
    required this.weight,
    required this.beerUnitSecondId,
    required this.status,
  });
  late final String beer;
  late final String name;
  late final double price;
  late final double discount;
  late final DateExpir? dateExpir;
  late final double volumetric;
  late final double weight;
  late final String beerUnitSecondId;
  late final String status;

  ListUnit.fromJson(Map<String, dynamic> json) {
    beer = json['beer'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    dateExpir = null;
    volumetric = json['volumetric'];
    weight = json['weight'];
    beerUnitSecondId = json['beer_unit_second_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['beer'] = beer;
    _data['name'] = name;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['dateExpir'] = dateExpir;
    _data['volumetric'] = volumetric;
    _data['weight'] = weight;
    _data['beer_unit_second_id'] = beerUnitSecondId;
    _data['status'] = status;
    return _data;
  }
}

class DateExpir {
  DateExpir({
    required this.day,
    required this.month,
    required this.year,
  });
  late final int day;
  late final int month;
  late final int year;

  DateExpir.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}
