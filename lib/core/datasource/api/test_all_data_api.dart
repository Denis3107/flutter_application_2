import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_application_2/core/datasource/repository/all_data_repository_impl.dart';
import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';
import 'package:uuid/uuid.dart';

class TestProductsDataApi implements ProductsDataApi {
  @override
  Future<AllData> getAllData() async {
    final Faker faker = Faker.instance;

    await Future.delayed(const Duration(seconds: 3), () {});

    final List<Product> products = List.generate(
      100,
      (index) => Product(
        uid: const Uuid().v1(),
        name: faker.commerce.productName(),
        price: faker.datatype.number(min: 0, max: 1000).toDouble(),
        number: faker.datatype.number(min: 0, max: 100).toDouble(),
      ),
    ).toList();

    return AllData(products: products);
  }
}
