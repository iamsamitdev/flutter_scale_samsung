// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/models/ProductModel.dart';
import 'package:flutter_scale/screens/bottompage/product_item_list.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/colors.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    CallAPI().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        body: FutureBuilder(
          future: CallAPI().getAllProducts(), 
          builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasError) {
                return Center(
                  child: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล'), // แสดงข้อความเมื่อเกิด Error
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                // อ่่านค่าจาก API สำเร็จ แล้วส่งค่ามาใส่ใน model
                List<ProductModel> products = snapshot.data;
                return ProductItemList(products);
              } else {
                // loading...
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AppRouter.addProduct);
          },
          child: Icon(Icons.add, color: icons,),
          backgroundColor: accent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
