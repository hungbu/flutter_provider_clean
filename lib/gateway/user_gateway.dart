import 'package:cleanproject/gateway/api_gateway.dart';
import 'package:cleanproject/model/user.dart';
import 'package:cleanproject/model/user_mockup.dart';

class UserGateWay extends APIGateway {
  Future<List<User>> fetchAll() async {

    // fetch data from server
    // var response = await httpClient.get('path');
    // List<User> result = (response as List<dynamic>).map((u) => User.fromJson(u)).toList();
    // return result;

    // return users from mockup data
    return getListUserMockup();
  }
  Future<User> fetchMe() async {
    return getMe();
  }
}