import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';
import 'package:flutter_application_2/core/presentation/widgets/product_widget.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProductWidget extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.orange,
      ),
    );
  }

  Widget bodyData(List<Product> products) {
    if (products.isEmpty) {
      return const Center(
        child: Text('Нічого не знайдено'),
      );
    }

    return ListView(
      children: products.map((Product product) => ProductWidget(product: product)).toList(),
    );
  }

  Widget resultSearchWidget() {
    return Consumer(builder: (context, ref, child) {
      final AsyncValue<List<Product>> searchProduct = ref.watch(searchProductProvider(query));

      return searchProduct.when(
        data: (products) => bodyData(products),

        ///
        error: (_, st) => Center(
          child: Text('Помилка !'),
        ),

        ///
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) => resultSearchWidget();

  @override
  Widget buildSuggestions(BuildContext context) => resultSearchWidget();
}
