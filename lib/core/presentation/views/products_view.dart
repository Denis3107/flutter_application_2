// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_application_2/core/domain/entities/all_data.dart';
import 'package:flutter_application_2/core/domain/entities/product.dart';
import 'package:flutter_application_2/core/presentation/widgets/product_widget.dart';
import 'package:flutter_application_2/core/presentation/widgets/search_product_widget.dart';

class ProductsView extends StatelessWidget {
  final AllData allData;

  const ProductsView({
    Key? key,
    required this.allData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список продуктів'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: SearchProductWidget(),
            ),
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      ///
      body: ListView(
        children: allData.products.map((Product product) => ProductWidget(product: product)).toList(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
