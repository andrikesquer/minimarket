import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos2/main.dart';
import 'package:pos2/presentation/providers/providers.dart';
import 'package:pos2/domain/entities/entities.dart';

class EditingForm extends ConsumerWidget {
  EditingForm({super.key});

  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodePrice = FocusNode();
  final FocusNode focusNodeStock = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(editingProductProvider);

    final product = ref.watch(selectedProductProvider);

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
        final updateProduct = Product(
          id: product!.id,
          name: nameController.text,
          price: double.parse(priceController.text),
          stock: int.parse(stockController.text),
        );

        objectbox.updateProduct(updateProduct);

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

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 20),
      child:
          isEditing
              ? Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Actualizando Producto',
                      style: TextStyle(fontSize: 25),
                    ),
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
                        updateProduct(context);
                      },
                      textInputAction: TextInputAction.go,
                    ),
                    confirmationButtons(),
                  ],
                ),
              )
              : Container(),
    );
  }
}
