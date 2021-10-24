import 'package:cleanproject/model/user.dart';

List<User> getListUserMockup() {
  List<User> users = [
  User(id: 1, name: "employer 1", avatar: 'https://mdbcdn.b-cdn.net/img/new/avatars/2.jpg'),
  User(id: 2, name: "employer 2", avatar: "https://mdbcdn.b-cdn.net/img/new/avatars/1.jpg"),
  User(id: 3, name: "employer 3", avatar: "https://mdbcdn.b-cdn.net/img/new/avatars/5.jpg"),
  User(id: 4, name: "employer 4", avatar: "https://mdbcdn.b-cdn.net/img/new/avatars/8.jpg"),
  ];
  return users;
}

User getMe() {
  return User(id: 1, name: "employer 1", avatar: 'https://mdbcdn.b-cdn.net/img/new/avatars/2.jpg');
}
User getUserById(int userId) {
  return getListUserMockup().firstWhere((user) => user.id == userId, orElse: () => getMe());
}
