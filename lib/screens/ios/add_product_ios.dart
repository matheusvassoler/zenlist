import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenlist/data/product_dao.dart';
import 'package:zenlist/model/product.dart';

class AddProductIOS extends StatelessWidget {
  final nameFieldController = TextEditingController();
  final quantityFieldController = TextEditingController();
  final priceFieldController = TextEditingController();
  final Product? product;

  AddProductIOS({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    nameFieldController.text = product?.name ?? "";
    quantityFieldController.text = product?.quantity.toString() ?? "";
    priceFieldController.text = product?.price.toString() ?? "";
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Adicionar Produto"),
      ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 20.0, top: 32.0),
            child: Form(
                child: Column(
                  children: [
                    CupertinoTextFormFieldRow(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      controller: nameFieldController,
                      placeholder: "Nome do produto",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CupertinoTextFormFieldRow(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        controller: quantityFieldController,
                        placeholder: "Quantidade",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: CupertinoTextFormFieldRow(
                        onChanged: (newText) {
                          if (newText.contains(",")) {
                            priceFieldController.text = newText.replaceAll(",", ".");
                          }
                        },
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        controller: priceFieldController,
                        placeholder: "Preço",
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          onPressed: () async {
                            await ProductDAO().addProduct(
                                Product(
                                    product?.id,
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
        ),
    );
  }
}
