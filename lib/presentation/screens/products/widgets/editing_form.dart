import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/presentation/providers/products/products_provider.dart';

class EditingForm extends ConsumerWidget {
  EditingForm({super.key});

  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodePrice = FocusNode();
  final FocusNode focusNodeStock = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEditing = ref.watch(editingProductProvider);

    final Product? product = ref.watch(selectedProductProvider);

    final TextEditingController nameController = TextEditingController(
      text: product?.name,
    );
    final TextEditingController priceController = TextEditingController(
      text: '${product?.price}',
    );
    final TextEditingController stockController = TextEditingController(
      text: '${product?.stock}',
    );

    void updateProduct(BuildContext context) {
      if (_formKey.currentState!.validate()) {
        final Product updateProduct = Product(
          id: product!.id,
          name: nameController.text,
          price: double.parse(priceController.text),
          stock: int.parse(stockController.text),
        );

        ref.watch(productsProvider.notifier).add(updateProduct);
        // objectbox.updateProduct(updateProduct);

        ref.read(productsProvider.notifier).refresh();
        ref.read(editingProductProvider.notifier).toggleEditProduct();
        ref.read(selectedProductProvider.notifier).state = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Producto actualizado correctamente'),
            backgroundColor: Colors.green[600],
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    Widget confirmationButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                updateProduct(context);
              },
              child: const Text('Actualizar'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                ref.read(editingProductProvider.notifier).toggleEditProduct();
              },
              child: const Text('Cerrar'),
            ),
          ),
        ],
      );
    }

    Widget editForm() {
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Actualizando Producto', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            TextFormField(
              focusNode: focusNodeName,
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.short_text_outlined),
                hintText: 'Nombre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el nombre del producto, por favor';
                }
                return null;
              },
              onFieldSubmitted: (String _) {
                focusNodePrice.requestFocus();
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: focusNodePrice,
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
                hintText: 'Precio',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el precio del producto, por favor';
                }
                return null;
              },
              onFieldSubmitted: (String _) {
                focusNodeStock.requestFocus();
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: focusNodeStock,
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money_outlined),
                hintText: 'Stock inicial',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese el stock inicial del producto, por favor';
                }
                return null;
              },
              onFieldSubmitted: (String _) {
                updateProduct(context);
              },
              textInputAction: TextInputAction.go,
            ),
            confirmationButtons(),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child: isEditing ? editForm() : Container(),
    );
  }
}
