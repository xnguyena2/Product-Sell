class UserInfoQuery {
  String id = '';
  int page = 0;
  int size = 0;

  UserInfoQuery(int p, int s, String id) {
    this.page = p;
    this.size = s;
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['page'] = page;
    _data['size'] = size;
    return _data;
  }
}
