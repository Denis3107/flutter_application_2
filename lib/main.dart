import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/datasource/api/test_all_data_api.dart';
import 'package:flutter_application_2/core/datasource/data/database.dart';
import 'package:flutter_application_2/core/datasource/data/drift_local_databace.dart';
import 'package:flutter_application_2/core/datasource/repository/database_repository_impl.dart';
import 'package:flutter_application_2/core/datasource/repository/all_data_repository_impl.dart';
import 'package:flutter_application_2/core/domain/repository/all_data_repository.dart';
import 'package:flutter_application_2/core/presentation/states/database_states.dart';
import 'package:flutter_application_2/core/presentation/view_model/home_view_model.dart';
import 'package:flutter_application_2/core/presentation/view_model/products_view_model.dart';
import 'package:flutter_application_2/core/presentation/views/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/domain/repository/database_repository.dart';

final Provider<DriftLocalDatabase> driftLocalDatabaseProvider = Provider((ref) => DriftLocalDatabase(driftDatabase: Database()));

final Provider<LocalDatabaseRepository> localDatabaseRepository =
    Provider((ref) => LocalDatabaseRepositoryImpl(localDatabace: ref.read(driftLocalDatabaseProvider)));

final Provider<TestProductsDataApi> testProductsDataApiProvider = Provider((ref) => TestProductsDataApi());

///
final Provider<AllDataRepository> allDataRepository = Provider((ref) => AllDataRepositoryImpl(allDataApi: ref.read(testProductsDataApiProvider)));

///
final searchProductProvider = FutureProvider.autoDispose.family((ref, String productName) {
  final LocalDatabaseRepository localDatabase = ref.watch(localDatabaseRepository);
  return localDatabase.searchProduct(productName);
});

///
final StateNotifierProvider<HomeViewModel, DatabaseState> homeViewModelProvider = StateNotifierProvider<HomeViewModel, DatabaseState>(
  (ref) => HomeViewModel(
    localDatabaseRepository: ref.read(localDatabaseRepository),
    allDataRepository: ref.read(allDataRepository),
  ),
);

///
// final productsViewModel = StateNotifierProvider((ref) => ProductsViewModel( localDatabaseRepository: ref.read(localDatabaseRepository), allData: null));

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
