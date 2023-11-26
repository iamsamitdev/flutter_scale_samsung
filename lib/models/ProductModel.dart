// ignore_for_file: file_names

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

String productModelToJsonWithoutID(ProductModel data) => json.encode(data.toJsonWithoutID());

class ProductModel {

    // Properties
    int? productId;
    int? categoryId;
    String? productName;
    int? unitPrice;
    String? productPicture;
    int? unitInStock;
    DateTime? createdDate;
    DateTime? modifiedDate;

    // Constructor
    ProductModel({
        this.productId,
        this.categoryId,
        this.productName,
        this.unitPrice,
        this.productPicture,
        this.unitInStock,
        this.createdDate,
        this.modifiedDate,
    });

    // Factory method สำหรับแปลงข้อมูลที่ได้รับมาจาก API ให้เป็น Object
    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productId: json["productID"],
        categoryId: json["categoryID"],
        productName: json["productName"],
        unitPrice: json["unitPrice"],
        productPicture: json["productPicture"],
        unitInStock: json["unitInStock"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        modifiedDate: json["modifiedDate"] == null ? null : DateTime.parse(json["modifiedDate"]),
    );

    // Method สำหรับแปลง Object ให้เป็น JSON
    Map<String, dynamic> toJson() => {
        "productID": productId,
        "categoryID": categoryId,
        "productName": productName,
        "unitPrice": unitPrice,
        "productPicture": productPicture,
        "unitInStock": unitInStock,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
    };

    // Mehod to toJson without ProductID
    Map<String, dynamic> toJsonWithoutID() => {
        "categoryID": categoryId,
        "productName": productName,
        "unitPrice": unitPrice,
        "productPicture": productPicture,
        "unitInStock": unitInStock,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedDate": modifiedDate?.toIso8601String(),
    };

    // Override toString
    @override
    String toString() {
      return '''
      {
        productId: $productId, 
        categoryId: $categoryId, 
        productName: $productName, 
        unitPrice: $unitPrice, 
        productPicture: $productPicture, 
        unitInStock: $unitInStock, 
        createdDate: $createdDate,
         modifiedDate: $modifiedDate
      }
      ''';
    }
}
