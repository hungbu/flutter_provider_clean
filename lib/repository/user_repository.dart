import 'package:cleanproject/gateway/user_gateway.dart';
import 'package:cleanproject/model/user.dart';

class UserRepository {
  UserGateWay? _userGateWay;

  // build singleton
  static final UserRepository _singleton = UserRepository._internal();
  UserRepository._internal();

  factory UserRepository({UserGateWay? userGateWay}) {
    _singleton._userGateWay = userGateWay;
    return _singleton;
  }


  List<User> _users = [];
  List<User> get users => _users;

  User? _me;
  User? get me => _me;

  Future fetchUsers() async {
    _users = await _userGateWay!.fetchAll();
  }

  Future fetchMe() async {
    _me = await _userGateWay!.fetchMe();
  }
}