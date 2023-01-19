import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/presentation/states/database_states.dart';
import 'package:flutter_application_2/core/presentation/view_model/home_view_model.dart';
import 'package:flutter_application_2/core/presentation/views/products_view.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DatabaseState dataState = ref.watch(homeViewModelProvider);
    final HomeViewModel homeViewModel = ref.read(homeViewModelProvider.notifier);

    Widget bodyData(DatabaseStateDataState state) {
      if (state.allData.products.isEmpty) {
        return Center(
          child: TextButton(
            child: Text('Завантажити базу даних'),
            onPressed: () => homeViewModel.loadDataBase(),
          ),
        );
      }

      return Center(child: Text('Тіпа список замовлень'));
    }

    Widget loadWidget() {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        centerTitle: true,
      ),

      ///
      body: dataState.when(
        databaseStateInitState: (_) => loadWidget(),
        databaseStateLoadState: (_) => loadWidget(),
        databaseStateDataState: (DatabaseStateDataState state) => bodyData(state),
        databaseStateErrorState: (_) => const Center(
          child: Text('Ти шо їбанутий, ти шо тут робиш ?'),
        ),
      ),

      floatingActionButton: dataState is DatabaseStateDataState
          ? FloatingActionButton(
              onPressed: dataState.allData.products.isEmpty
                  ? null
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsView(allData: dataState.allData),
                        ),
                      ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
