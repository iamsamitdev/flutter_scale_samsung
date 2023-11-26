// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

var initRoute;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {

  // ใช้งาน HttpOverrides
  HttpOverrides.global = MyHttpOverrides();

  // ต้องเรียกใช้ WidgetsFlutterBinding.ensureInitialized()
  // เพื่อให้สามารถเรียกใช้ SharedPreferences ได้
  WidgetsFlutterBinding.ensureInitialized();

  // สร้างตัวแปร prefs ไว้เก็บค่า SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // ตรวจสอบว่าเคยแสดง Intro แล้วหรือยัง 
  if (prefs.getBool('welcomeStatus') == true) {
      initRoute = AppRouter.login;
    if(prefs.getBool('isLogin') == true){
      initRoute = AppRouter.dashboard;
    }
  } else {
    initRoute = AppRouter.welcome;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Scale',
      theme: AppTheme.lightTheme,
      initialRoute: initRoute,
      routes: AppRouter.routes,
    );
  }
}

