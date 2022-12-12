import 'package:flutter/material.dart';
import '../widgets/dots.dart';
import '../Screens/Splash2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Splash2(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: Center(
              child: Image.asset('images/splash.png'),
            ),
          ),
          const SizedBox(height: 100.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dots(color: Colors.grey),
              const SizedBox(width: 5),
              dots(color: Colors.blueAccent),
              const SizedBox(width: 5),
              dots(color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
