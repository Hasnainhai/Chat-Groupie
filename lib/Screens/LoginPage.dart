import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/HomePage.dart';
import '../Screens/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  final _auth = FirebaseAuth.instance;
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Groupie\'s',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login your account now chat and explore',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Image.asset('images/login.png'),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoretion.copyWith(
                    label: const Text('Email'),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoretion.copyWith(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 46),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTrue = true;
                      });
                      try {
                        final newUser = _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);
                        if (newUser != null) {
                          nextPage(context, HomePage());
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        isTrue = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    text: 'Don\'t have account? ',
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.orangeAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isTrue = true;
                            });
                            nextPage(
                              context,
                              const RegisterPage(),
                            );
                            setState(() {
                              isTrue = false;
                            });
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
