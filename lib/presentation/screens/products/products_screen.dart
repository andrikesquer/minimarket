import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/presentation/providers/providers.dart';
import 'package:pos2/domain/entities/entities.dart';
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
    final allProducts = ref.read(productsProvider);

    setState(() {
      filteredProducts =
          allProducts
              .where(
                (p) =>
                    p.name.toLowerCase().contains(query.toLowerCase()) ||
                    p.id.toString().contains(query),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = ref.watch(productsProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ProductsAppBar(),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar producto',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterProducts,
            ),
            Column(
              children: [
                ProductTable(
                  products:
                      searchController.text.isEmpty
                          ? allProducts
                          : filteredProducts,
                ),
                ProductForm(),
                EditingForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
