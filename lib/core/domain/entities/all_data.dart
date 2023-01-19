// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_2/core/domain/entities/product.dart';

class AllData {
  final List<Product> products;

  AllData({
    required this.products,
  });

  AllData copyWith({
    List<Product>? products,
  }) {
    return AllData(
      products: products ?? this.products,
    );
  }
}
