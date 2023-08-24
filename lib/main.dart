import 'package:flutter/material.dart';
import 'package:productos_app/src/pages/home_pages.dart';
import 'package:productos_app/src/services/products_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ProductsService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Producto App',
      home: HomePage(),
    );
  }
}
