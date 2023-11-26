// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/screens/bottompage/notification_screen.dart';
import 'package:flutter_scale/screens/bottompage/profile_screen.dart';
import 'package:flutter_scale/screens/bottompage/report_screen.dart';
import 'package:flutter_scale/screens/bottompage/setting_screen.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // Read Profile login
  String? _username, _email;

  // สร้างฟังก์ชันอ่านข้อมูลจาก SharedPreferences
  readUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
      _email = prefs.getString('email');
    });
  }

  // สร้างตัวแปรไว้เก็บ title ของแต่ละ screen
  String _title = 'Flutter Scale';

  // สร้างตัวแปรไว้เก็บ index ของ bottom navigation bar
  late int _currentIndex;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  // สร้าง method สำหรับเปลี่ยนหน้า
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = "Home"; break;
        case 1: _title = "Report"; break;
        case 2: _title = "Notification"; break;
        case 3: _title = "Setting"; break;
        case 4: _title = "Profile"; break;
        default: _title = "Flutter Scale"; break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    readUserProfile();
  }

  // logout
  void logout() async {
    // Remove token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('isLogin');
    Navigator.pushReplacementNamed(context, AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        // backgroundColor
        // backgroundColor: primary,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(_username ?? ''), 
                  accountEmail: Text(_email ?? ''),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: Image.asset('assets/images/samitavt.jpg').image,
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: Image.asset('assets/images/noavartar.png').image,
                    ),
                    CircleAvatar(
                      backgroundImage: Image.asset('assets/images/noavartar.png').image,
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Info'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('About'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Contact'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: logout,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          onTabTapped(value);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: accent,
        unselectedItemColor: secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined), 
            label: 'Report'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined), 
            label: 'Notification'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), 
            label: 'Setting'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), 
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}
