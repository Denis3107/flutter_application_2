// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';
import 'package:flutter_application_2/core/domain/repository/database_repository.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  final LocalDatabace localDatabace;

  LocalDatabaseRepositoryImpl({
    required this.localDatabace,
  });

  @override
  Future<AllData> getAllData() => localDatabace.getAllProducts();

  @override
  Future<int> insertProduct(Product product) => localDatabace.insertProduct(product);

  @override
  Future<void> insertAll(AllData allData) => localDatabace.insertAll(allData);

  @override
  Future<List<Product>> searchProduct(String productName) => localDatabace.searchProduct(productName);
}

abstract class LocalDatabace {
  Future<AllData> getAllProducts();
  Future<int> insertProduct(Product product);
  Future<void> insertAll(AllData allData);
  Future<List<Product>> searchProduct(String productName);
}
