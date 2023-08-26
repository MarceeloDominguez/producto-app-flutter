import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/src/models/category_model.dart';
import 'package:productos_app/src/services/products_services.dart';
import 'package:productos_app/src/widget/input_home_page.dart';
import 'package:productos_app/src/widget/header_home_page.dart';
import 'package:productos_app/src/widget/card_pruduct.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xF3F3FDE8),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const HeaderHomePage(),
                  const InputHomePage(),
                  const _ListCategory(),
                ],
              ),
            ),
            const _CardsGrid(),
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

    return SizedBox(
      width: double.infinity,
      height: 50,
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
          borderRadius: BorderRadius.circular(8),
          color: providerCategorySelected.selectedCategory == category.name
              ? Colors.lightBlue
              : Colors.white54,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: providerCategorySelected.selectedCategory == category.name
                  ? Colors.white
                  : Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardsGrid extends StatelessWidget {
  const _CardsGrid();

  @override
  Widget build(BuildContext context) {
    return const CardProduct();
  }
}
