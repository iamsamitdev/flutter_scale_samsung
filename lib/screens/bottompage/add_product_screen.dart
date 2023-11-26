// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/models/ProductModel.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  // 1. Create a GlobalKey for the Form
  final _formKeyAdd = GlobalKey<FormState>();

  // 2. Declare a variable to store the value from the TextFormField
  String? _productName, _unitPrice, _unitStock, _productPicture, _categoryID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
      ),
      body: Form(
        key: _formKeyAdd,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomTextField(
              context,
              'Product name',
              (onValidate) => onValidate.isEmpty ? 'Please enter product name' : null,
              (onSaved) => _productName = onSaved,
            ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Product Picture',
                (onValidate) => onValidate.isEmpty ? 'Please enter product picture' : null,
                (onSaved) => _productPicture = onSaved,
              ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Unit Price',
                (onValidate) => onValidate.isEmpty ? 'Please enter product price' : null,
                (onSaved) => _unitPrice = onSaved,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Unit Stock',
                (onValidate) => onValidate.isEmpty ? 'Please enter Unit in stock' : null,
                (onSaved) => _unitStock = onSaved,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10,),
              CustomTextField(
                context,
                'Category ID',
                (onValidate) => onValidate.isEmpty ? 'Please enter Category ID' : null,
                (onSaved) => _categoryID = onSaved,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              CustomButton(
                () async {
                  if(_formKeyAdd.currentState!.validate()){
                    _formKeyAdd.currentState!.save();

                    // Call API Add Product
                    ProductModel productModel = ProductModel(
                      productName: _productName,
                      productPicture: _productPicture,
                      unitPrice: int.parse(_unitPrice!),
                      unitInStock: int.parse(_unitStock!),
                      categoryId: int.parse(_categoryID!),
                      createdDate: DateTime.now(),
                      modifiedDate: DateTime.now(),
                    );

                    var response = await CallAPI().addProduct(productModel);

                    // print(response);
                    if(response){

                      // Navigate to Home Screen
                      // Navigator.pop(context, true);
                      Navigator.of(context).pop();

                      // Refresh data in product list
                      refreshKey.currentState!.show();
                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          key: Key('snackbar_add_product_fail'),
                          content: Text('Add product failed'),
                          backgroundColor: Colors.red,
                        )
                      );
                    }
                    
                  }
                },
                'Submit',
                height: 60.0
              )
            ],
          ),
        ),
      ),
    );
  }
}