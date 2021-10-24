import 'package:cleanproject/common/constant.dart';
import 'package:cleanproject/model/job.dart';
import 'package:cleanproject/page/add_job.dart';
import 'package:cleanproject/page/home.dart';
import 'package:cleanproject/page/splash.dart';
import 'package:cleanproject/page/update_job.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRouter.splash:
      return MaterialPageRoute(builder: (context) => SplashPage());

      case AppRouter.home:
      return MaterialPageRoute(builder: (context) => HomePage());

    case AppRouter.addJob:
      return MaterialPageRoute(builder: (context) => AddJobPage());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}

final listRoute = {
  '/': (BuildContext context) => new SplashPage(),
};
