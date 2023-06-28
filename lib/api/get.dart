import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../model/boostrap.dart';
import '../model/region.dart';

Future<Products> fetchProduct(String id) async {
  final response = await get(Uri.parse('${host}/beer/detail/${id}'));

  if (response.statusCode == 200) {
    // print(response.body);
    return Products.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<RegionResult> fetchRegion() async {
  final response = await get(Uri.parse('${host}/address/allregionformat/'));

  if (response.statusCode == 200) {
    // print(response.body);
    return RegionResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}

Future<RegionResult> fetchDistrict(Region region) async {
  final response =
      await get(Uri.parse('${host}/address/districtformat/${region.id}'));

  if (response.statusCode == 200) {
    // print(response.body);
    return RegionResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}

Future<RegionResult> fetchWard(Region region, Region district) async {
  final response = await get(
      Uri.parse('${host}/address/wardformat/${region.id}/${district.id}'));

  if (response.statusCode == 200) {
    // print(response.body);
    return RegionResult.fromJson(
      {"list_result": jsonDecode(utf8.decode(response.bodyBytes))},
    );
  } else {
    throw Exception('Failed to load data');
  }
}
