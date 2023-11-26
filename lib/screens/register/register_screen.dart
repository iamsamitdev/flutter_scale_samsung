// ignore_for_file: unused_field, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formKeyRegis = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  bool _obscurePassword = true;

  // ตัวแปรสำหรับเก็บค่าจากฟอร์ม
  late String _firstname, _lastname, _email, _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ลงทะเบียน"),
      ),
      body: Form(
        key: _formKeyRegis,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/images/samsung_logo.png', width: 200),
              const SizedBox(height: 60),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Firstname",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "กรุณากรอกชื่อ";
                  }
                  return null;
                },
                onSaved: (value){
                  _firstname = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Lastname",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "กรุณากรอกนามสกุล";
                  }
                  return null;
                },
                onSaved: (value){
                  _lastname = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "กรุณากรอกอีเมล์";
                  }
                  return null;
                },
                onSaved: (value){
                  _email = value!;
                },
              ),
              const SizedBox(height: 10),
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
                validator: (value) {
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
                validator: (value) {
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
                    child: const Text("ลงทะเบียน", style: TextStyle(fontSize: 18),),
                    onPressed: () async {
                      // เช็คว่าป้อนข้อมูลครบ validate ผ่านแล้ว
                      if(_formKeyRegis.currentState!.validate()){
                        // บันทึกข้อมูลลงตัวแปร
                        _formKeyRegis.currentState!.save();

                        // Call Register API
                        var response = await CallAPI().registerAPI(
                          {
                            "username": _username,
                            "email": _email,
                            "password": _password,
                          }
                        );

                        var body = jsonDecode(response.body);

                        // print(body);
                        if(body['status'] == 'Success'){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              key: Key('snackbar_register_success'),
                              content: Text(body['message']),
                              backgroundColor: Colors.green,
                            )
                          );
                          // ส่งกลับไปหน้า login
                          Navigator.pop(context);
                        }else{
                          // แจ้งเตือน
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              key: Key('snackbar_register_fail'),
                              content: Text(body['message']),
                              backgroundColor: Colors.red,
                            )
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
                        "เป็นสมาชิกแล้ว ?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          _formKeyRegis.currentState?.reset();
                          Navigator.pop(context); // กลับไปหน้าก่อนหน้านี้
                        },
                        child: const Text(
                          "เข้าสู่ระบบ",
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