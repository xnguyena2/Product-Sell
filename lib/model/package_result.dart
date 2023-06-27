import 'package:intl/intl.dart';

import 'boostrap.dart';

class PackageResult {
  PackageResult({
    required this.listResult,
  });
  late final List<ListResult> listResult;

  PackageResult.fromJson(Map<String, dynamic> json) {
    listResult = List.from(json['list_result'])
        .map((e) => ListResult.fromJson(e))
        .toList();
  }

  int calcTotal() {
    return listResult.fold(
        0, (previousValue, element) => previousValue + element.numberUnit);
  }

  void sort() {
    listResult.sort(
      (a, b) =>
          stringToDateTime(b.createat).compareTo(stringToDateTime(a.createat)),
    );
  }

  DateTime stringToDateTime(String dateValue) {
    return DateFormat("y-MM-ddThh:mm:ss.sssZ").parse(dateValue);
  }

  double totalPrice() {
    return listResult.fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            element.numberUnit *
                element.beerSubmitData.listUnit[0].price *
                (1 - element.beerSubmitData.listUnit[0].discount / 100));
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['list_result'] = listResult.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ListResult {
  ListResult({
    this.id,
    required this.deviceId,
    required this.beerId,
    required this.beerUnit,
    required this.numberUnit,
    this.status,
    required this.createat,
    required this.beerSubmitData,
  });
  late final Null id;
  late final String deviceId;
  late final String beerId;
  late final String beerUnit;
  int numberUnit = 0;
  late final Null status;
  late final String createat;
  late final BeerSubmitData beerSubmitData;

  ListResult.fromJson(Map<String, dynamic> json) {
    id = null;
    deviceId = json['device_id'];
    beerId = json['beer_id'];
    beerUnit = json['beer_unit'];
    numberUnit = json['number_unit'];
    status = null;
    createat = json['createat'];
    beerSubmitData = BeerSubmitData.fromJson(json['beerSubmitData']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['device_id'] = deviceId;
    _data['beer_id'] = beerId;
    _data['beer_unit'] = beerUnit;
    _data['number_unit'] = numberUnit;
    _data['status'] = status;
    _data['createat'] = createat;
    _data['beerSubmitData'] = beerSubmitData.toJson();
    return _data;
  }
}

class BeerSubmitData {
  BeerSubmitData({
    required this.beerSecondID,
    required this.name,
    required this.detail,
    required this.category,
    required this.status,
    this.images,
    required this.listUnit,
  });
  late final String beerSecondID;
  late final String name;
  late final String detail;
  late final String category;
  late final String status;
  late final List<Images>? images;
  late final List<ListUnit> listUnit;

  BeerSubmitData.fromJson(Map<String, dynamic> json) {
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
