import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenlist/components/shopping_item.dart';
import 'package:zenlist/data/product_dao.dart';
import 'package:zenlist/model/product.dart';
import 'package:zenlist/screens/ios/add_product_ios.dart';

class ShoppingListIOS extends StatefulWidget {
  const ShoppingListIOS({super.key});

  @override
  State<ShoppingListIOS> createState() => _ShoppingListIOSState();
}

class _ShoppingListIOSState extends State<ShoppingListIOS> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Lista de Compras"),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(onPressed: () {
                  showCupertinoDialog(context: context, builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("Excluir todos os produtos"),
                      content: Text("Deseja realmente excluir todos os produtos?"),
                      actions: [
                        CupertinoDialogAction(
                          child: Text("Não"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: Text("Sim"),
                          isDestructiveAction: true,
                          onPressed: () {
                            ProductDAO().deleteAllProducts();
                            Navigator.pop(context);
                            setState(() {});
                          },
                        )
                      ],
                    );
                  });
                }, icon: Icon(Icons.delete)),
              ),
              IconButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductIOS())
                ).then((value) => setState(() {}));
              }, icon: Icon(Icons.add)),
            ]
          )
        ),
        child: SafeArea(
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
