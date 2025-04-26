import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/presentation/providers/products/products_provider.dart';
import 'package:pos2/presentation/screens/products/widgets/products.dart';

class Products extends ConsumerStatefulWidget {
  const Products({super.key});

  @override
  ConsumerState<Products> createState() => _ProductsState();
}

class _ProductsState extends ConsumerState<Products> {
  final TextEditingController searchController = TextEditingController();
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = ref.read(productsProvider);
  }

  void _filterProducts(String query) {
    final List<Product> allProducts = ref.read(productsProvider);

    setState(() {
      filteredProducts =
          allProducts
              .where(
                (Product p) =>
                    p.name.toLowerCase().contains(query.toLowerCase()) ||
                    p.id.toString().contains(query),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> allProducts = ref.watch(productsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: ProductsAppBar(),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar producto',
              ),
              onChanged: _filterProducts,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ProductTable(
                  products:
                      searchController.text.isEmpty
                          ? allProducts
                          : filteredProducts,
                ),
                NewProductForm(),
                EditingForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
