class UserInfo {
  String? username;
  String? password;

  UserInfo({required this.username, required this.password});

  UserInfo.fromMap(Map<String, String> res)
      : username = res["username"],
        password = res["password"];

  Map<String, String?> toMap() {
    return {'username': username, 'password': password};
  }
}
