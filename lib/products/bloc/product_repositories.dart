import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:internship_project/models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> readProducts() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('json/products.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}
