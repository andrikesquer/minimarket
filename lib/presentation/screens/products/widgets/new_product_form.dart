import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/domain/entities/product_entity.dart';
import 'package:pos2/presentation/providers/products/products_provider.dart';

class NewProductForm extends ConsumerWidget {
  NewProductForm({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodePrice = FocusNode();
  final FocusNode focusNodeStock = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAdding = ref.watch(addingProductProvider);

    void saveProduct(BuildContext context) {
      if (_formKey.currentState!.validate()) {
        final Product newProduct = Product(
          name: nameController.text,
          price: double.parse(priceController.text),
          stock: int.parse(stockController.text),
        );

        ref.read(productsProvider.notifier).add(newProduct);

        nameController.clear();
        priceController.clear();
        stockController.clear();
        focusNodeName.requestFocus();

        ref.read(productsProvider.notifier).refresh();
        ref.read(addingProductProvider.notifier).toggleAddProduct();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Producto guardado correctamente'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green[600],
          ),
        );
      }
    }

    Widget addButton() {
      return ElevatedButton(
        onPressed: () {
          ref.read(addingProductProvider.notifier).toggleAddProduct();
        },
        child: Text('Agregar'),
      );
    }

    Widget confirmationButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                saveProduct(context);
              },
              child: const Text('Guardar'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                ref.read(addingProductProvider.notifier).toggleAddProduct();
              },
              child: const Text('Cerrar'),
            ),
          ),
        ],
      );
    }

    Widget newProductForm() {
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Nuevo Producto!', style: TextStyle(fontSize: 20)),
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
                saveProduct(context);
              },
              textInputAction: TextInputAction.go,
            ),
            confirmationButtons(),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 15),
      child: !isAdding ? addButton() : newProductForm(),
    );
  }
}
