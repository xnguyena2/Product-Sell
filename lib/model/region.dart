class RegionResult {
  RegionResult({
    required this.listResult,
  });
  late final List<Region> listResult;

  RegionResult.fromJson(Map<String, dynamic> json) {
    listResult =
        List.from(json['list_result']).map((e) => Region.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['list_result'] = listResult.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Region {
  Region({
    required this.name,
    required this.id,
  });
  late final String name;
  late final int id;

  Region.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    return _data;
  }
}
