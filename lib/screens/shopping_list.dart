import 'package:flutter/material.dart';
import 'package:zenlist/components/shopping_item.dart';
import 'package:zenlist/data/product_dao.dart';
import 'package:zenlist/model/product.dart';
import 'package:zenlist/screens/add_product.dart';

class ShoppingList extends StatefulWidget {
  ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Compras"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ProductDAO().deleteAllProducts();
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct())
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
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
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
