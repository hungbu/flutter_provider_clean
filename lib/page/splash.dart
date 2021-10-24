import 'package:cleanproject/common/constant.dart';
import 'package:cleanproject/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  //const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _initApplication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(width: 60, height: 60, child: CircularProgressIndicator(),)));
  }

  // init env, state .. of application
  _initApplication() async {
    await Provider.of<UserRepository>(context, listen: false).fetchMe();
    await Provider.of<UserRepository>(context, listen: false).fetchUsers();

    Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.home, (Route<dynamic> route) => false);
    return;
  }
}
