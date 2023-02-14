// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drift/drift.dart';
import 'package:flutter_application_2/core/datasource/data/database.dart';
import 'package:flutter_application_2/core/datasource/repository/database_repository_impl.dart';
import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';

class DriftLocalDatabase implements LocalDatabace {
  final Database driftDatabase;

  DriftLocalDatabase({
    required this.driftDatabase,
  });

  @override
  Future<AllData> getAllProducts() async {
    final List<ProductsTableData> products = await driftDatabase.select(driftDatabase.productsTable).get();

    return AllData(
      products: products.map((product) => _convertToProduct(product)).toList(),
    );
  }

  @override
  Future<void> insertAll(AllData allData) async {
    final List<ProductsTableData> products = allData.products.map((Product product) => _convertToDBProduct(product)).toList();
    driftDatabase.transaction(
      () async {
        await driftDatabase.batch((bath) {
          bath.insertAll(driftDatabase.productsTable, products, mode: InsertMode.insertOrReplace);
        });
      },
    );
  }

  @override
  Future<int> insertProduct(Product product) => driftDatabase.into(driftDatabase.productsTable).insert(_convertToDBProduct(product));

  @override
  Future<List<Product>> searchProduct(String productName) async {
    final List<ProductsTableData> searchProduct =
        await (driftDatabase.select(driftDatabase.productsTable)..where((tbl) => tbl.name.contains(productName))).get();

    return searchProduct.map((ProductsTableData product) => _convertToProduct(product)).toList();
  }

  Product _convertToProduct(ProductsTableData product) {
    return Product(
      uid: product.uid,
      name: product.name,
      price: product.price,
      number: product.number,
    );
  }

  ProductsTableData _convertToDBProduct(Product product) {
    return ProductsTableData(
      uid: product.uid,
      name: product.name,
      price: product.price,
      number: product.number,
    );
  }
}
