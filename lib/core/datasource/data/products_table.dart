import 'package:drift/drift.dart';

class ProductsTable extends Table {
  TextColumn get uid => text()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  RealColumn get number => real()();
}
