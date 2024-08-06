import 'package:flutter/material.dart';
import 'package:WebHopers/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  void _navigateToHomePage() async {
    // Delay for 2 seconds (or any duration you prefer)
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the HomePage and replace the splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [

          Image.asset(
            'assets/images/webhopers.logo.jpg',

          ),
          // Overlay Text

        ],
      ),
    );
  }
}
