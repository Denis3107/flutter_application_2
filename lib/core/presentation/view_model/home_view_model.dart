import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/repository/all_data_repository.dart';
import 'package:flutter_application_2/core/domain/repository/database_repository.dart';
import 'package:flutter_application_2/core/presentation/states/database_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<DatabaseState> {
  final LocalDatabaseRepository localDatabaseRepository;
  final AllDataRepository allDataRepository;

  HomeViewModel({
    required this.localDatabaseRepository,
    required this.allDataRepository,
  }) : super(DatabaseStateInitState()) {
    _init();
  }

  _init() async {
    final AllData allData = await localDatabaseRepository.getAllData();
    state = DatabaseStateDataState(allData: allData);
  }

  void setState(DatabaseState value) {
    state = value;
  }

  void loadDataBase() async {
    state = DatabaseStateLoadState();

    final AllData allData = await allDataRepository.getAllData();

    await localDatabaseRepository.insertAll(allData);

    final AllData localAllData = await localDatabaseRepository.getAllData();
    state = DatabaseStateDataState(allData: localAllData);
  }
}
