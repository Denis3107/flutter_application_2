import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/repository/database_repository.dart';
import 'package:flutter_application_2/core/presentation/view_model/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DatabaseState {
  T when<T>({
    required T Function(DatabaseStateInitState value) databaseStateInitState,
    required T Function(DatabaseStateLoadState value) databaseStateLoadState,
    required T Function(DatabaseStateDataState value) databaseStateDataState,
    required T Function(DatabaseStateErrorState value) databaseStateErrorState,
  }) {
    final DatabaseState thisValue = this;

    if (thisValue is DatabaseStateInitState) return databaseStateInitState(thisValue);
    if (thisValue is DatabaseStateLoadState) return databaseStateLoadState(thisValue);
    if (thisValue is DatabaseStateDataState) return databaseStateDataState(thisValue);
    if (thisValue is DatabaseStateErrorState) return databaseStateErrorState(thisValue);

    throw '';
  }
}

class DatabaseStateInitState extends DatabaseState {}

class DatabaseStateLoadState extends DatabaseState {}

class DatabaseStateDataState extends DatabaseState {
  final AllData allData;
  DatabaseStateDataState({required this.allData});
}

class DatabaseStateErrorState extends DatabaseState {}
