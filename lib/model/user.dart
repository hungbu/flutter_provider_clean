class User {
  int? id;
  String? name;
  String? avatar;

  User({this.id, this.name, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      name: json['name'],
      avatar: json['avatar'],
      id: json['name']
    );
  }
}