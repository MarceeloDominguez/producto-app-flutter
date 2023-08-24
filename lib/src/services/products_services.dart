import 'package:flutter/widgets.dart';
import 'package:productos_app/src/models/category_model.dart';
import 'package:productos_app/src/models/products_model.dart';
import 'package:productos_app/src/data/products.dart';

class ProductsService with ChangeNotifier {
  String _selectedCategory = 'adidas';
  //inicializo _products con la lista de productos que viene de data
  List<Product> get _products => listProducts;

  List<Category> categories = [
    Category('adidas'),
    Category('nike'),
    Category('topper'),
    Category('puma'),
  ];

  get selectedCategory => _selectedCategory;

  void handleSelectedCategory(String category) {
    _selectedCategory = category;

    notifyListeners();
  }

  // List<Product> get products => _selectedCategory == 'adidas'
  //     ? _products
  //     : _products
  //         .where((element) => element.category == _selectedCategory)
  //         .toList();

  List<Product> get products => _products
      .where((element) => element.category == _selectedCategory)
      .toList();
}
