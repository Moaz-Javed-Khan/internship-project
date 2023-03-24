import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String image;
  final int maxItem;
  final String name;
  final String description;
  final bool featured;
  final PriceModel price;

  const ProductModel({
    required this.id,
    required this.image,
    required this.maxItem,
    required this.name,
    required this.description,
    required this.featured,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'maxItem': maxItem,
      'name': name,
      'description': description,
      'featured': featured,
      'price': price.toJson(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      maxItem: json['maxItem'],
      name: json['name'],
      description: json['description'],
      featured: json['featured'],
      price: PriceModel.fromJson(json['price']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        image,
        maxItem,
        name,
        description,
        featured,
        price,
      ];
}

class PriceModel extends Equatable {
  final double amount;
  final String currency;

  const PriceModel({
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

  @override
  List<Object?> get props => [amount, currency];
}
