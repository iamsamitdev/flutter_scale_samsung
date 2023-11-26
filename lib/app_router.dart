// ignore_for_file: prefer_const_constructors
import 'package:flutter_scale/screens/bottompage/add_product_screen.dart';
import 'package:flutter_scale/screens/bottompage/edit_product_screen.dart';
import 'package:flutter_scale/screens/bottompage/product_detail_screen.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawerpage/about_screen.dart';
import 'package:flutter_scale/screens/drawerpage/contact_screen.dart';
import 'package:flutter_scale/screens/drawerpage/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/register/register_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

class AppRouter {

  // Router Map Key
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String dashboard = 'dashboard';
  static const String info = 'info';
  static const String about = 'about';
  static const String contact = 'contact';
  static const String productDetail = 'productDetail';
  static const String addProduct = 'addProduct';
  static const String editProduct = 'editProduct';

  // Router Map
  static get routes => {
    welcome: (context) => WelcomeScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    dashboard: (context) => DashboardScreen(),
    info: (context) => InfoScreen(),
    about: (context) => AboutScreen(),
    contact: (context) => ContactScreen(),
    productDetail: (context) => ProductDetail(),
    addProduct: (context) => AddProductScreen(),
    editProduct: (context) => EditProductScreen(),
  };

}