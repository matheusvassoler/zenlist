import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenlist/data/product_dao.dart';
import 'package:zenlist/model/product.dart';

class AddProduct extends StatelessWidget {
  final nameFieldController = TextEditingController();
  final quantityFieldController = TextEditingController();
  final priceFieldController = TextEditingController();

  AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: nameFieldController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nome do produto"
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: quantityFieldController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Quantidade"
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: priceFieldController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Preço"
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await ProductDAO().addProduct(
                          Product(
                            null,
                            nameFieldController.text,
                            int.parse(quantityFieldController.text),
                            double.parse(priceFieldController.text)
                          )
                        );
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Adicionar"),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
