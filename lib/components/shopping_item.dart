import 'package:flutter/material.dart';
import 'package:zenlist/data/product_dao.dart';
import 'package:zenlist/screens/add_product.dart';

import '../model/product.dart';

class ShoppingItem extends StatelessWidget {
  final Product product;
  final Function onProductDelete;
  final Function onProductUpdate;
  const ShoppingItem({super.key, required this.product, required this.onProductDelete, required this.onProductUpdate});

  @override
  Widget build(BuildContext context) {
    double totalPrice = product.price * product.quantity;
    return GestureDetector(
      onLongPress: () {
        ProductDAO().deleteProduct(product);
        onProductDelete();
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct(product: product))
        ).then((value) => onProductUpdate());
      },
      child: SizedBox(
        height: 80,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("R\$ ${product.price.toStringAsFixed(2)}"),
                  ]
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantidade: ${product.quantity}"),
                    Text("R\$ ${totalPrice.toStringAsFixed(2)}"),
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
