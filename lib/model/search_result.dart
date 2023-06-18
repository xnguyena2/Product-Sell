import 'boostrap.dart';

class SearchResult {
  SearchResult({
    required this.count,
    required this.searchTxt,
    required this.result,
    required this.normalSearch,
  });
  late final int count;
  late final String searchTxt;
  late final List<Products> result;
  late final bool normalSearch;

  SearchResult.fromJson(Map<String, dynamic> json) {
    count = double.parse(json['count'].toString()).toInt();
    searchTxt = json['searchTxt'];
    result =
        List.from(json['result']).map((e) => Products.fromJson(e)).toList();
    normalSearch = json['normalSearch'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['searchTxt'] = searchTxt;
    _data['result'] = result.map((e) => e.toJson()).toList();
    _data['normalSearch'] = normalSearch;
    return _data;
  }
}
