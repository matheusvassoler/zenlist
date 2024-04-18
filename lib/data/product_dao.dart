import 'package:sqflite/sqflite.dart';
import 'package:zenlist/data/database.dart';
import 'package:zenlist/model/product.dart';
import 'package:zenlist/zenlist_constants.dart';

class ProductDAO {

  Future<List<Product>>? getAll() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(productsTable);

    return _toList(result);
  }

  addProduct(Product product) async {
    Database db = await getDatabase();
    Map<String, dynamic> productMap = _toMap(product);
    if (product.id == null) {
      db.insert(productsTable, productMap);
    } else {
      db.update(productsTable, productMap, where: "id = ?", whereArgs: [product.id]);
    }
  }

  deleteProduct(Product product) async {
    Database db = await getDatabase();
    db.delete(productsTable, where: "id = ?", whereArgs: [product.id]);
  }

  deleteAllProducts() async {
    Database db = await getDatabase();
    db.delete(productsTable);
  }

  List<Product> _toList(List<Map<String, dynamic>> result) {
    List<Product> products = [];
    for (Map<String, dynamic> row in result) {
      Product product = Product(
        row["id"],
        row["name"],
        row["quantity"],
        row["price"]
      );
      products.add(product);
    }
    return products;
  }

  Map<String, dynamic> _toMap(Product product) {
    Map<String, dynamic> productMap = {
      "id": product.id,
      "name": product.name,
      "quantity": product.quantity,
      "price": product.price
    };

    return productMap;
  }
}