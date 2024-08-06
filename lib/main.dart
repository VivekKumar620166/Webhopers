// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:webhopers/view/home_page.dart';
// // import 'controllers/product_controller.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (context) => ProductController(),
// //       child: MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: '',
// //         theme: ThemeData(
// //           primarySwatch: Colors.green,
// //         ),
// //         home: HomePage(),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
//
// import 'package:WebHopers/view/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'models/cart_provider.dart';
// import 'controllers/product_controller.dart';
//
//
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CartProvider()),
//         ChangeNotifierProvider(create: (_) => ProductController()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

import 'package:WebHopers/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:WebHopers/view/home_page.dart';
import 'controllers/product_controller.dart';
import 'models/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen as the home widget
    );
  }
}
