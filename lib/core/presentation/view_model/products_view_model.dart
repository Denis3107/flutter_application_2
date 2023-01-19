import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';
import 'package:flutter_application_2/core/domain/repository/database_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ProductsViewModel extends StateNotifier<AllData> {
  ///знаю шо хуїта, но в тебе не питав бо було ще рано
  final LocalDatabaseRepository localDatabaseRepository;

  ProductsViewModel({
    required AllData allData,
    required this.localDatabaseRepository,
  }) : super(allData);

  void addProduct() {
    final Faker faker = Faker.instance;

    final Product product = Product(
      uid: const Uuid().v1(),
      name: faker.commerce.productName(),
      price: faker.datatype.number(min: 0, max: 1000).toDouble(),
      number: faker.datatype.number(min: 0, max: 100).toDouble(),
    );

    ////аля добавленіє

    localDatabaseRepository.insertProduct(product);
  }
}
