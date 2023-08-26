import 'package:flutter/material.dart';
import 'package:productos_app/src/models/products_model.dart';
import 'package:productos_app/src/services/products_services.dart';
import 'package:provider/provider.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final product = productsService.products;

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
                    child: Column(
                      children: [
                        _ImageProduct(product[index]),
                        _InfoProduct(product[index]),
                        const SizedBox(height: 10),
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
          childAspectRatio: 0.65,
          mainAxisExtent: 255,
        ),
      ),
    );
  }
}

class _ImageProduct extends StatelessWidget {
  final Product product;

  const _ImageProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        // ignore: unnecessary_null_comparison
        child: product != null
            ? Image(
                alignment: Alignment.topCenter,
                image: NetworkImage(
                  product.image,
                ),
              )
            : const Image(
                alignment: Alignment.topCenter,
                image: NetworkImage(
                  'https://nikearprod.vtexassets.com/arquivos/ids/717498-1000-1000?v=1779194544&width=1000&height=1000&aspect=true',
                ),
              ),
      ),
    );
  }
}

class _InfoProduct extends StatelessWidget {
  final Product product;

  const _InfoProduct(this.product);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
