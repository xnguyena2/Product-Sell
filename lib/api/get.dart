import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../model/boostrap.dart';

Future<Products> fetchProduct(String id) async {
  final response = await get(Uri.parse('${host}/beer/detail/${id}'));

  if (response.statusCode == 200) {
    // print(response.body);
    return Products.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}
