// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/models/ProductModel.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  // 1. Create a GlobalKey for the Form
  final _formKeyEdit = GlobalKey<FormState>();

  // 2. Declare a variable to store the value from the TextFormField
  String? _productName, _unitPrice, _unitStock, _productPicture, _categoryID;

  @override
  Widget build(BuildContext context) {

    // รับค่าจาก arguments ที่ส่งมาจากหน้า product_item_list.dart
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['products']['productName']),
      ),
      body: Form(
        key: _formKeyEdit,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomTextField(
              context,
              'Product name',
              (onValidate) => onValidate.isEmpty ? 'Please enter product name' : null,
              (onSaved) => _productName = onSaved,
              initialValue: arguments['products']['productName'].toString(),
            ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Product Picture',
                (onValidate) => onValidate.isEmpty ? 'Please enter product picture' : null,
                (onSaved) => _productPicture = onSaved,
                initialValue: arguments['products']['productPicture'].toString(),
              ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Unit Price',
                (onValidate) => onValidate.isEmpty ? 'Please enter product price' : null,
                (onSaved) => _unitPrice = onSaved,
                keyboardType: TextInputType.number,
                initialValue: arguments['products']['unitPrice'].toString(),
              ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Unit Stock',
                (onValidate) => onValidate.isEmpty ? 'Please enter Unit in stock' : null,
                (onSaved) => _unitStock = onSaved,
                keyboardType: TextInputType.number,
                initialValue: arguments['products']['unitInStock'].toString(),
              ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Category ID',
                (onValidate) => onValidate.isEmpty ? 'Please enter Category ID' : null,
                (onSaved) => _categoryID = onSaved,
                keyboardType: TextInputType.number,
                initialValue: arguments['products']['categoryID'].toString(),
              ),
              SizedBox(height: 20,),
              CustomButton(
                () async {
                  if(_formKeyEdit.currentState!.validate()){
                    _formKeyEdit.currentState!.save();

                    // Call API Add Product
                    ProductModel productModel = ProductModel(
                      productId: int.parse(arguments['products']['productID'].toString()),
                      productName: _productName,
                      productPicture: _productPicture,
                      unitPrice: int.parse(_unitPrice!),
                      unitInStock: int.parse(_unitStock!),
                      categoryId: int.parse(_categoryID!),
                      modifiedDate: DateTime.now(),
                    );

                    var response = await CallAPI().updateProduct(productModel);

                    print(response);

                    if(response){

                      // Navigate to Home Screen
                      Navigator.pop(context, true);

                      // Refresh data in product list
                      refreshKey.currentState!.show();
                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          key: Key('update_product_fail'),
                          content: Text('Update product failed'),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                    
                  }
                },
                'Update',
                height: 60.0
              )
            ],
          ),
        ),
      ),
    );
  }
}