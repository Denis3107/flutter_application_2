// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drift/drift.dart';
import 'package:flutter_application_2/core/datasource/data/database.dart' as db;
import 'package:flutter_application_2/core/datasource/repository/database_repository_impl.dart';
import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';

class DriftLocalDatabace implements LocalDatabace {
  final db.Database driftDatabase;

  DriftLocalDatabace({
    required this.driftDatabase,
  });

  @override
  Future<AllData> getAllProducts() async {
    final List<db.Product> products = await driftDatabase.select(driftDatabase.products).get();

    /// да да тут меду для тебе хватає. обсирай, обсирай мене полностю
    return AllData(
      products: products.map((db.Product product) => _convertToProduct(product)).toList(),
    );
  }

  @override
  Future<void> insertAll(AllData allData) async {
    final List<db.Product> products = allData.products.map((Product product) => _convertToDBProduct(product)).toList();
    driftDatabase.transaction(
      () async {
        await driftDatabase.batch((bath) {
          bath.insertAll(driftDatabase.products, products, mode: InsertMode.insertOrReplace);
        });
      },
    );
  }

  @override
  Future<int> insertProduct(Product product) => driftDatabase.into(driftDatabase.products).insert(_convertToDBProduct(product));

  @override
  Future<List<Product>> searchProduct(String productName) async {
    final List<db.Product> searchProduct = await (driftDatabase.select(driftDatabase.products)..where((tbl) => tbl.name.contains(productName))).get();

    return searchProduct.map((db.Product product) => _convertToProduct(product)).toList();
  }

  Product _convertToProduct(db.Product product) {
    return Product(
      uid: product.uid,
      name: product.name,
      price: product.price,
      number: product.number,
    );
  }

  db.Product _convertToDBProduct(Product product) {
    return db.Product(
      uid: product.uid,
      name: product.name,
      price: product.price,
      number: product.number,
    );
  }
}
