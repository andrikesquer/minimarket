import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/presentation/providers/providers.dart';
import 'package:pos2/domain/entities/entities.dart';

class ProductTable extends ConsumerWidget {
  final List<Product> products;

  const ProductTable({super.key, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    editProduct(int productId) {
      final product = products.firstWhere((p) => p.id == productId);
      ref.read(selectedProductProvider.notifier).state = product;
      ref.read(editingProductProvider.notifier).toggleEditProduct();
    }

    deleteProduct(int productId) {
      ref.read(productsProvider.notifier).delete(productId);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          if (products.isNotEmpty)
            DataTable(
              columns: [
                DataColumn(label: Text('ID'), numeric: true),
                DataColumn(label: Text('Producto')),
                DataColumn(label: Text('Precio'), numeric: true),
                DataColumn(label: Text('Stock'), numeric: true),
                DataColumn(label: Text('Editar')),
                DataColumn(label: Text('Eliminar')),
              ],
              rows:
                  products.map((product) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${product.id}')),
                        DataCell(Text(product.name)),
                        DataCell(Text('\$${product.price}')),
                        DataCell(Text('${product.stock}')),
                        DataCell(
                          Icon(Icons.edit),
                          onTap: () {
                            editProduct(product.id);
                          },
                        ),
                        DataCell(
                          Icon(Icons.delete),
                          onTap: () {
                            deleteProduct(product.id);
                          },
                        ),
                      ],
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }
}
