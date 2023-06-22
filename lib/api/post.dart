import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import '../model/search_query.dart';
import '../model/search_result.dart';
import '../utils/vntone.dart';

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
