import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../model/boostrap.dart';
import '../model/order_result.dart';
import '../model/package_item_remove.dart';
import '../model/package_order.dart';
import '../model/package_result.dart';
import '../model/product_package.dart';
import '../model/response.dart';
import '../model/search_query.dart';
import '../model/search_result.dart';
import '../model/user_info_query.dart';
import '../utils/vntone.dart';

Future<BootStrap> fetchBootstrap() async {
  final response = await get(Uri.parse('${host}/clientdevice/bootstrap'));

  if (response.statusCode == 200) {
    // print(response.body);
    return BootStrap.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<SearchResult> fetchMoreResult(int page) async {
  final filter = SearchQuery("all", page, 24, "default");
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/beer/getall'),
    body: jsonEncode(filter),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return SearchResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<SearchResult> fetchSearchResult(SearchQuery filter) async {
  filter.query = removeVNTones(filter.query);
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/beer/search'),
    body: jsonEncode(filter),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return SearchResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<PackageResult> fetchPackageResult(UserInfoQuery query) async {
  query.page = 0;
  query.size = 10000;
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/package/getall'),
    body: jsonEncode(query),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return PackageResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ResponseResult> addToPackage(ProductPackage productPackage) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/package/add'),
    body: jsonEncode(productPackage),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return ResponseResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<dynamic> deleteItemFromPackage(ProductPackage productPackage) async {
  PackageItemRemove itemRemove = PackageItemRemove(
      deviceId: productPackage.deviceID,
      unitId: productPackage.beerUnits[0].beerUnitID);
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/package/remove'),
    body: jsonEncode(itemRemove),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return jsonDecode(utf8.decode(response.bodyBytes));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<OrderResult> createOrder(Order order) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await post(
    Uri.parse('${host}/order/create'),
    body: jsonEncode(order),
    headers: headers,
  );

  if (response.statusCode == 200) {
    // print(response.body);
    return OrderResult.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}
