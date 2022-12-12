import 'package:demo_chat/Screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/Widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPafgeState();
}

class _RegisterPafgeState extends State<RegisterPage> {
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
                  'Create your accout to chat and explore',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Image.asset('images/register.png'),
                const SizedBox(height: 16),
                TextFormField(
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
                  decoration: textInputDecoretion.copyWith(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 46),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isTrue = true;
                      });
                      try {
                        final newUser = _auth.createUserWithEmailAndPassword(
                            email: email!, password: password!);

                        if (newUser != null) {
                          previousPage(context, LoginPage());
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        isTrue = false;
                      });
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 16),
                Text.rich(
                  TextSpan(
                    text: 'Already have account? ',
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.orangeAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isTrue = true;
                            });
                            previousPage(
                              context,
                              LoginPage(),
                            );
                            setState(() {
                              isTrue = false;
                            });
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
