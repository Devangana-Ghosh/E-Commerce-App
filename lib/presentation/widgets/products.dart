import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../Screen/checkout.dart';
import 'package:hive/hive.dart';

import 'cart_item.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Box<CartItem> cartBox; // Initialize cartBox

  @override
  void initState() {
    super.initState();
    cartBox = Hive.box<CartItem>('cart'); // Initialize cartBox
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var i = 0; i < cartBox.length; i++) {
      var item = cartBox.getAt(i) as CartItem;
      totalPrice += item.price;
    }
    return totalPrice;
  }

  void removeFromCart(int index) {
    setState(() {
      cartBox.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartBox.isEmpty
                ? Center(child: Text('Your Cart is Empty'))
                : ListView.builder(
              itemCount: cartBox.length,
              itemBuilder: (BuildContext context, int index) {
                var item = cartBox.getAt(index) as CartItem;
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('\$${item.price}'),
                  leading: Image.network(
                    item.image,
                    width: 50,
                    height: 50,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeFromCart(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price: \$${getTotalPrice()}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage(cartItems: cartBox.values.toList())),
                    );
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



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
          // Add a button to the AppBar
          IconButton(
            icon: Icon(Icons.shopping_cart), // You can use any icon you prefer
            onPressed: () {
              // Navigate to the CartPage when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()), // Replace 'CartPage()' with your actual cart page widget
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
