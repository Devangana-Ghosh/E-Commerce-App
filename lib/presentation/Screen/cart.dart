import 'package:flutter/material.dart';
import '../Screen/checkout.dart';
import 'package:hive/hive.dart';
import '../widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Box<CartItem> cartBox;

  @override
  void initState() {
    super.initState();
    cartBox = Hive.box<CartItem>('cart');
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
        title: Text('Cart (${cartBox.length})'),
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
                      removeFromCart(index); },
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
                Text(
                  'Total Price: \$${getTotalPrice()}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CheckoutPage(cartItems: cartBox.values.toList()),
                      ),
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
