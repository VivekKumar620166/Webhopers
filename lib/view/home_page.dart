import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../models/cart_provider.dart';
import '../models/product.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> _bannerImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];
  // final PageController _pageController = PageController();
  final PageController _pageController = PageController();
  bool _scrollingLeftToRight = true;
  int _currentPageIndex = 0;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_pageController.hasClients) {
        if (_scrollingLeftToRight) {
          _currentPageIndex++;
          if (_currentPageIndex >= _bannerImages.length) {
            _scrollingLeftToRight = false;
            _currentPageIndex = _bannerImages.length - 1; // Set to last index
          }
        } else {
          _currentPageIndex--;
          if (_currentPageIndex < 0) {
            _scrollingLeftToRight = true;
            _currentPageIndex = 0;
          }
        }

        _pageController.animateToPage(
          _currentPageIndex,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {},
        ),
        title: Center(
          child: Text(
            'WebHopers',
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Consumer<ProductController>(
            builder: (context, controller, child) {
              if (controller.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Here',
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.black, width: 0.9),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * (2 / 3),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: PageView.builder(
                        itemCount: _bannerImages.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                _bannerImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        controller: _pageController,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Categories',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategory('Jackets', 'assets/images/banner3.png'),
                          _buildCategory('Shirts', 'assets/images/shirt.png'),
                          _buildCategory('T-Shirts', 'assets/images/tshirt.png'),
                          _buildCategory('Cloths', 'assets/images/banner1.png'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Recently Ordered',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 240,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.products.length > 5 ? 5 : controller.products.length,
                        itemBuilder: (context, index) {
                          final product = controller.products[index];
                          return _buildHorizontalProductCard(context, product);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Seasonal Products',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.products.length > 5 ? 5 : controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return _buildVerticalProductCard(context, product);
                      },
                    ),
                    SizedBox(height:45),
                  ],
                ),
              );
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              if (cartProvider.itemCount > 0) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items in Cart: ${cartProvider.itemCount}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'Total Price: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String name, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProductCard(BuildContext context, Product product) {
    final cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 1)),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                product.imageUrl,
                width: 96,
                height: 96,



              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    product.title,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 5),
                  Text(
                    'Price \$${product.price}',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  SizedBox(height: 15,),
                  cartProvider.isProductInCart(product)
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.decreaseQuantity(product);
                        },
                      ),
                      Text(
                        '${cartProvider.getQuantity(product)}',
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartProvider.increaseQuantity(product);
                        },
                      ),
                    ],
                  )
                      : Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        cartProvider.addToCart(product);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalProductCard(BuildContext context, Product product) {
    final cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
              child: Image.network(
                product.imageUrl,
                width: 96,
                height: 96,

              ),
            ),
            SizedBox(width: 8), // Space between image and text

            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4),

                    // Product Price
                    Text(
                      'Price: \$${product.price}',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),

                    // Add to Cart Button
                    Align(
                      alignment: Alignment.bottomRight,
                      child: cartProvider.isProductInCart(product)
                          ? Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              cartProvider.decreaseQuantity(product);
                            },
                          ),
                          Text(
                            '${cartProvider.getQuantity(product)}',
                            style: TextStyle(fontSize: 14),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cartProvider.increaseQuantity(product);
                            },
                          ),
                        ],
                      )
                          : ElevatedButton(
                        onPressed: () {
                          cartProvider.addToCart(product);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
