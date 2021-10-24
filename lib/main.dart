import 'package:cleanproject/common/setup_provider.dart';
import 'package:cleanproject/page/splash.dart';
import 'package:flutter/material.dart';
import 'package:cleanproject/common/route.dart' as route;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providerSetup,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
          onGenerateRoute: route.generateRoute,

        ));

  }
}
