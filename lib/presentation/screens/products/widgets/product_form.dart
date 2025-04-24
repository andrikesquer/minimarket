import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/main.dart';
import 'package:pos2/presentation/providers/providers.dart';
import 'package:pos2/domain/entities/entities.dart';

class ProductForm extends ConsumerWidget {
  ProductForm({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodePrice = FocusNode();
  final FocusNode focusNodeStock = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdding = ref.watch(addingProductProvider);

    void saveProduct(BuildContext context) {
      if (_formKey.currentState!.validate()) {
        final newProduct = Product(
          name: nameController.text,
          price: double.parse(priceController.text),
          stock: int.parse(stockController.text),
        );

        final id = objectbox.addProduct(newProduct);

        debugPrint('Producto guardado con ID: $id');

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

    return Container(
      padding: EdgeInsets.only(top: 20),
      child:
          !isAdding
              ? addButton()
              : Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text('Nuevo Producto!', style: TextStyle(fontSize: 25)),
                    TextFormField(
                      focusNode: focusNodeName,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el nombre del producto, por favor';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        focusNodePrice.requestFocus();
                      },
                    ),
                    TextFormField(
                      focusNode: focusNodePrice,
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Precio'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el precio del producto, por favor';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        focusNodeStock.requestFocus();
                      },
                    ),
                    TextFormField(
                      focusNode: focusNodeStock,
                      controller: stockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Stock inicial',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el stock inicial del producto, por favor';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        saveProduct(context);
                      },
                      textInputAction: TextInputAction.go,
                    ),
                    confirmationButtons(),
                  ],
                ),
              ),
    );
  }
}
