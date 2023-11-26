// ignore_for_file: unused_element
import 'dart:convert';
import 'package:flutter_scale/models/ProductModel.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallAPI {

  // สร้างตัวแปรไว้เก็บ token
  static String _token = '';

  // สร้างฟังก์ชันอ่านข้อมูล token จาก SharedPreferences
  static _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    // print(_token);
  }

  // Set Headers for login/register
  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // Set Headers for products
  _setHeadersWithAuth() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
  };

  // Register User API
  registerAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}Authenticate/register'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // Login User API
  loginAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}Authenticate/login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // CRUD Products API
  // Get All Products
  Future<List<ProductModel>?> getAllProducts() async {
    await _getToken();
    final response = await http.get(
      Uri.parse('${baseURLAPI}Products'),
      headers: _setHeadersWithAuth(),
    );

    if(response.body != null) {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }

  // Add Product API Call Method
  Future<bool> addProduct(ProductModel data) async {
    await _getToken();
    final response = await http.post(
      Uri.parse('${baseURLAPI}Products'),
      body: productModelToJsonWithoutID(data),
      headers: _setHeadersWithAuth(),
    );

    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Update Product API Call Method
  Future<bool> updateProduct(ProductModel data) async {
    await _getToken();
    final response = await http.put(
      Uri.parse('${baseURLAPI}Products/${data.productId}'),
      body: productModelToJson(data),
      headers: _setHeadersWithAuth(),
    );

    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete Product API Call Method
  Future<bool> deleteProduct(int id) async {
    await _getToken();
    final response = await http.delete(
      Uri.parse('${baseURLAPI}Products/$id'),
      headers: _setHeadersWithAuth(),
    );

    // if response return no content (204) then return true
    if(response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

}