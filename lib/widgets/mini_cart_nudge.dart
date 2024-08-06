import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_provider.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cart',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
      ),
      body: cartProvider.itemCount > 0
          ? ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          final product = cartProvider.cartItems.keys.toList()[index];
          final quantity = cartProvider.cartItems[product]!;

          return ListTile(
            leading: Image.network(product.imageUrl, width: 50),
            title: Text(product.title),
            subtitle: Text('Quantity: $quantity\nPrice: \$${product.price * quantity}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                cartProvider.decreaseQuantity(product);
              },
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No items in the cart',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: cartProvider.itemCount > 0
          ? Container(
        padding: EdgeInsets.all(16),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle checkout or other action
              },
              child: Text('Checkout',style: TextStyle(color: Colors.green),),
            ),
          ],
        ),
      )
          : null,
    );
  }
}
