import 'dart:convert';

class SearchQuery {
  String query = '';
  int page = 0;
  int size = 0;
  String filter = '';

  SearchQuery(String q, int p, int s, String f) {
    if (f == '') {
      f = 'default';
    }
    query = q;
    page = p;
    size = s;
    filter = f;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['query'] = query;
    _data['page'] = page;
    _data['size'] = size;
    _data['filter'] = filter;
    return _data;
  }
}
