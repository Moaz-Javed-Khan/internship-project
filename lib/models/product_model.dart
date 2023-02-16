class ProductModel {
  final int id;
  final int maxItem;
  final String name;
  final String description;
  final PriceModel price;

  ProductModel({
    required this.id,
    required this.maxItem,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'maxItem': maxItem,
      'name': name,
      'description': description,
      'price': price.toJson(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      maxItem: json['maxItem'],
      name: json['name'],
      description: json['description'],
      price: PriceModel.fromJson(json['price']),
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

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      amount: json['amount'],
      currency: json['currency'],
    );
  }
}
