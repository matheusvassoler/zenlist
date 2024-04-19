import 'package:flutter/material.dart';
import 'package:zenlist/components/shopping_item.dart';
import 'package:zenlist/data/product_dao.dart';
import 'package:zenlist/model/product.dart';
import 'package:zenlist/screens/android/add_product_android.dart';

class ShoppingListAndroid extends StatefulWidget {
  const ShoppingListAndroid({super.key});

  @override
  State<ShoppingListAndroid> createState() => _ShoppingListAndroidState();
}

class _ShoppingListAndroidState extends State<ShoppingListAndroid> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Compras"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Excluir todos os produtos"),
                    content: Text("Deseja realmente excluir todos os produtos?"),
                    actions: [
                      TextButton(
                        child: Text("Não"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("Sim"),
                        onPressed: () {
                          ProductDAO().deleteAllProducts();
                          Navigator.pop(context);
                          setState(() {});
                        },
                      )
                    ],
                  );
                }
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductAndroid())
              ).then((value) => setState(() {}));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(future: ProductDAO().getAll(), builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Product>? products = snapshot.data;
              if (products != null && products.isNotEmpty) {
                int totalProducts = 0;
                double totalPrice = 0;
                for (Product product in products) {
                  totalProducts += product.quantity;
                  totalPrice += product.price * product.quantity;
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ShoppingItem(
                              product: products[index],
                              onProductDelete: () {
                                setState(() {

                                });
                              },
                              onProductUpdate: () {
                                setState(() {

                                });
                              },
                            );
                          }
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 1,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 40,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Total: "),
                                  Text(totalProducts.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("R\$ ${totalPrice.toStringAsFixed(2)}"),
                                ],
                              )
                            ],
                          ),
                        )
                    )
                  ],
                );
              } else {
                return Text("Nenhum produto cadastrado");
              }
            } else {
              return Text("");
            }
          }),
        )
      ),
    );
  }
}
