import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/src/models/category_model.dart';
import 'package:productos_app/src/services/products_services.dart';
import 'package:productos_app/src/widget/input_home_page.dart';
import 'package:productos_app/src/widget/header_home_page.dart';

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
    final productsService = Provider.of<ProductsService>(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, index) {
            return GestureDetector(
              onTap: () => print('Click en el card...'),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(0, 0))
                        ]),
                    child: const Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image(
                              alignment: Alignment.topCenter,
                              image: NetworkImage(
                                  'https://nikearprod.vtexassets.com/arquivos/ids/717498-1000-1000?v=1779194544&width=1000&height=1000&aspect=true'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trail Running Jacket Nike Windrunner',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '\$99',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const Positioned(
                    right: 10,
                    top: 10,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: productsService.products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.67,
        ),
      ),
    );
  }
}
