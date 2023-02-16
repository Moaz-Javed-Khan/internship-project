import 'package:internship_project/models/product_model.dart';

class CartItemModel {
  final int quantity;
  final double subTotal;
  final double total;
  final ProductModel product;

  CartItemModel({
    required this.quantity,
    required this.subTotal,
    required this.total,
    required this.product,
  });

  CartItemModel increment() {
    var newQuantity = quantity;
    if (quantity <= product.maxItem) {
      newQuantity = quantity + 1;
    }
    return CartItemModel(
      product: product,
      quantity: newQuantity,
      subTotal: subTotal * (newQuantity),
      total: total,
    );
  }

  CartItemModel decrement() {
    var newQuantity = quantity;
    if (quantity > 0) {
      newQuantity = quantity - 1;
    }

    return CartItemModel(
      product: product,
      quantity: newQuantity,
      subTotal: subTotal * (newQuantity),
      total: total,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'subTotal': subTotal,
      'total': total,
      'product': product.toJson(),
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      quantity: json['quantity'] as int,
      subTotal: json['subTotal'] as double,
      total: json['total'] as double,
      product: ProductModel.fromJson(json['product']),
    );
  }
}
