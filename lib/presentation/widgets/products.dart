import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Screen/cart.dart';
import 'cart_item.dart';


class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<dynamic> products = [];
  late Box<CartItem> cartBox;

  @override
  void initState() {
    super.initState();
    _getProducts();
    cartBox = Hive.box<CartItem>('cart');
  }

  Future<void> _getProducts() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void addToCart(dynamic product) {
    final cartItem = CartItem(
      title: product['title'],
      price: product['price'].toDouble(),
      image: product['image'],
    );
    cartBox.add(cartItem);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          dynamic product = products[index];
          return ListTile(
            title: Text(product['title']),
            subtitle: Text('\$${product['price']}'),
            leading: Image.network(
              product['image'],
              width: 50,
              height: 50,
            ),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addToCart(product);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),);
              },
            ),
          );
        },
      ),
    );
  }
}