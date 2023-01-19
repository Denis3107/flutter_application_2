import 'package:flutter_application_2/core/domain/entities/all_data.dart';

import '../entities/product.dart';

abstract class LocalDatabaseRepository {
  Future<AllData> getAllData();
  Future<int> insertProduct(Product product);
  Future<void> insertAll(AllData allData);
  Future<List<Product>> searchProduct(String productName);
}
