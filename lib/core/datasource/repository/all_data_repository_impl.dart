import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';
import 'package:flutter_application_2/core/domain/repository/all_data_repository.dart';

class AllDataRepositoryImpl implements AllDataRepository {
  final ProductsDataApi allDataApi;

  AllDataRepositoryImpl({
    required this.allDataApi,
  });

  @override
  Future<AllData> getAllData() => allDataApi.getAllData();
}

abstract class ProductsDataApi {
  Future<AllData> getAllData();
}
