import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wishlist/presentation/Screen/login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wishlist/presentation/Screen/theme.dart';
import 'package:wishlist/presentation/widgets/cart_item.dart';
import 'package:provider/provider.dart';


void main() async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>('cart');
  } catch (e) {
    print('Error initializing Hive: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeModel>(context);

    return MaterialApp(
      title: "cashncarry",
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      home: Scaffold(
        body: Column(
          children: [
            AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.lightbulb_outline),
                  color: Colors.black, // Set the color here
                  onPressed: () {
                    themeProvider.toggleTheme(); // Toggle between light and dark mode
                  },
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Expanded(
              child: LoginPage(),
            ),
          ],
        ),
      ),
    );


  }}