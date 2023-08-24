import 'package:flutter/material.dart';
import 'package:productos_app/src/models/category_model.dart';
import 'package:productos_app/src/services/products_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _ListCategory(),
            Expanded(
              child: ListView.builder(
                itemCount: productsService.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(productsService.products[index].name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListCategory extends StatelessWidget {
  const _ListCategory();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.amber,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ButtonCategory(category: categories[index]),
                ],
              ),
            );
          }),
    );
  }
}

class _ButtonCategory extends StatelessWidget {
  final Category category;

  const _ButtonCategory({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final providerCategorySelected = Provider.of<ProductsService>(context);

    return GestureDetector(
      onTap: () {
        final categoryService =
            Provider.of<ProductsService>(context, listen: false);
        categoryService.handleSelectedCategory(category.name);
      },
      child: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: providerCategorySelected.selectedCategory == category.name
                  ? Colors.red
                  : Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
