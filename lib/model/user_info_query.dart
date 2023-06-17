class UserInfoQuery {
  String id = '';
  int page = 0;
  int size = 0;

  UserInfoQuery(int p, int s, String id) {
    this.page = p;
    this.size = s;
    this.id = id;
  }
}
