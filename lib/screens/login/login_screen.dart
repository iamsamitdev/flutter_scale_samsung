// ignore_for_file: prefer_const_constructors, unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final GlobalKey<FormState> _formKeyLogin = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  bool _obscurePassword = true;

   // ตัวแปรสำหรับเก็บค่าจากฟอร์ม
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyLogin,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 180),
              Image.asset('assets/images/samsung_logo.png', width: 200),
              const SizedBox(height: 60),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: 'iamsamit',
                validator: (value){
                  if(value!.isEmpty) {
                    return "กรุณากรอกชื่อผู้ใช้งาน";
                  }
                  return null;
                },
                onSaved: (value){
                  _username = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                focusNode: _focusNodePassword,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: 'Samit@1234',
                validator: (value){
                  if(value!.isEmpty) {
                    return "กรุณากรอกรหัสผ่าน";
                  }
                  return null;
                },
                onSaved: (value){
                  _password = value!;
                },
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("เข้าสู่ระบบ", style: TextStyle(fontSize: 18),),
                    onPressed: () async {
                      // เช็คว่าป้อนข้อมูลครบ validate ผ่านแล้ว
                      if(_formKeyLogin.currentState!.validate()){
                        
                        // บันทึกข้อมูลลงตัวแปร
                        _formKeyLogin.currentState!.save();

                        // Call API Login
                        var response = await CallAPI().loginAPI(
                          {
                            "username": _username,
                            "password": _password,
                          }
                        );

                        var body = jsonDecode(response.body);

                        // เช็ค login success or fail
                        if(response.statusCode == 200){

                          // Create shared preferences
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                          // Save token to shared preferences
                          sharedPreferences.setString('token', body['token']);
                          sharedPreferences.setString('username', body['userdata']['userName']);
                          sharedPreferences.setString('email', body['userdata']['email']);

                          // flag for login
                          sharedPreferences.setBool('isLogin', true);

                          // Navigate to dashboard
                          // Navigator.pushReplacementNamed(context, AppRouter.dashboard);
                          Navigator.pushNamedAndRemoveUntil(context, AppRouter.dashboard, (route) => false);
                        } else {
                          // Show alert dialog
                          showDialog(
                            context: context, 
                            builder: (context){
                              return AlertDialog(
                                title: const Text('เกิดข้อผิดพลาด'),
                                content: const Text('ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // close dialog
                                    }, 
                                    child: const Text('ตกลง'),
                                  ),
                                ],
                              );
                            }
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "ยังไม่เป็นสมาชิก ?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          _formKeyLogin.currentState?.reset();
                          Navigator.pushNamed(context, AppRouter.register);
                        },
                        child: const Text(
                          "สมัครที่นี่",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
