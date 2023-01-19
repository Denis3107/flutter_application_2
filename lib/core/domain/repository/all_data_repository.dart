import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';

abstract class AllDataRepository {
  Future<AllData> getAllData();
}
