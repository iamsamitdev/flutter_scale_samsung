// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names, use_build_context_synchronously, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/models/ProductModel.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';
// import 'package:intl/intl.dart';

Widget ProductItemList(List<ProductModel> products) {
  // final currency = new NumberFormat.currency(locale: 'th', symbol: '฿', decimalDigits: 2);

  return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel productModel = products[index];

        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                productModel.productPicture.toString(),
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${productModel.productName}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   "Price: ${currency.format(productModel.unitPrice)} THB",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //   ),
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      () => {
                        Navigator.pushNamed(context, AppRouter.productDetail,
                            arguments: {'products': productModel.toJson()})
                      },
                      'Views',
                      color: Colors.green,
                      textColor: Colors.white,
                    ),
                    CustomButton(
                      () => {
                        Navigator.pushNamed(context, AppRouter.editProduct,
                            arguments: {'products': productModel.toJson()})
                      },
                      'Edit',
                      color: Colors.yellow,
                      textColor: Colors.black,
                    ),
                    CustomButton(
                      () async {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this product?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Call API Delete Product
                                      var response = await CallAPI()
                                          .deleteProduct(
                                              productModel.productId!);
                                      if (response) {
                                        Navigator.of(context).pop();
                                        refreshKey.currentState!.show();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            key: Key('snackbar1'),
                                            content: Text('Delete product failed'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            });
                      },
                      'Delete',
                      color: Colors.red,
                      textColor: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
}
