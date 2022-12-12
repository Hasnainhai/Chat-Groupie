import 'package:flutter/material.dart';
import '../widgets/dots.dart';
import 'LoginPage.dart';

class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
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
              child: Image.asset('images/splash2.png'),
            ),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dots(color: Colors.grey),
              const SizedBox(width: 5),
              dots(color: Colors.grey),
              const SizedBox(width: 5),
              dots(color: Colors.blueAccent),
            ],
          ),
        ],
      ),
    );
  }
}
