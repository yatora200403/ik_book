import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ik_book/login.dart';
import 'package:ik_book/admin/homepageadmin.dart';
import 'package:ik_book/network.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();

  NetworkApi.setServerName = "192.168.0.110";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IK Book",
      home: LoginScreen(),
    );
  }
}
