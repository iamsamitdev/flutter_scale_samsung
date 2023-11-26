// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  final currency = new NumberFormat.currency(
    locale: 'th',
    symbol: '฿',
    decimalDigits: 2
  );

  final dateformat = new DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {

    // รับค่า parameter ที่ส่งมาจากหน้า product_item_list.dart
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // print(arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['products']['productName']),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(arguments['products']['productPicture']),
                fit: BoxFit.cover,
                alignment: Alignment.center
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: Text(
              arguments['products']['productName'], 
              style: TextStyle(
                fontSize: 28, 
                fontWeight: 
                FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              "Price: ${currency.format(arguments['products']['unitPrice'])} THB", 
              style: TextStyle(
                fontSize: 20, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              "${arguments['products']['unitInStock']} Items in stock", 
              style: TextStyle(
                fontSize: 20, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Text(
              "Created: ${dateformat.format(DateTime.parse(arguments['products']['createdDate']))}", 
              style: TextStyle(
                fontSize: 20, 
                fontStyle: FontStyle.italic
              ),
            ),
          ),
        ],
      ),
    );
  }
}