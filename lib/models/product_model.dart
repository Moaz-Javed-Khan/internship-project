class ProductModel {
  final int id;
  final int maxItem;
  final String name;
  final String description;
  final int quantity;
  final PriceModel price;

  ProductModel({
    required this.id,
    required this.maxItem,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      maxItem: json['maxItem'],
      name: json['name'],
      description: json['description'],
      quantity: 0,
      price: PriceModel.fromJson(json['price']),
    );
  }

  ProductModel increment() {
    var newQuantity = quantity;
    if (quantity <= maxItem) {
      newQuantity = quantity + 1;
    }
    return ProductModel(
      quantity: newQuantity,
      description: description,
      id: id,
      maxItem: maxItem,
      name: name,
      price: price,
    );
  }

  ProductModel decrement() {
    var newQuantity = quantity;
    if (quantity > 1) {
      newQuantity = quantity - 1;
    }

    return ProductModel(
      quantity: newQuantity,
      description: description,
      id: id,
      maxItem: maxItem,
      name: name,
      price: price,
    );
  }
}

class PriceModel {
  final double amount;
  final String currency;

  PriceModel({
    required this.amount,
    required this.currency,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}
