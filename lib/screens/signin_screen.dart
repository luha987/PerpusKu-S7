import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: _emailController.text.trim())
        .where('password', isEqualTo: _passwordController.text.trim())
        .get();

    if (user.docs.isNotEmpty) {
      // Navigate to home page if user is found
      Navigator.popAndPushNamed(context, '/home-screen');
    } else {
      // Show error message if user is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username dan Password Salah !!!'),
          backgroundColor: Colors.indigo[900], // Optional: Set background color for the Snackbar
          duration: Duration(seconds: 3), // Optional: Set duration for how long the Snackbar is shown
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang di \nPerpusKu :)',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.indigo[900]),
              ),
              Form(
                onChanged: () {},
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        label: Text('Username'),
                        hintText: 'Masukkan Username !',
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        hintText: 'Masukkan Password !',
                      ),
                      obscureText: true, // Hide password input
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Masuk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.indigo[900]),
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.indigo[900],
                    child: IconButton(
                      onPressed: _signIn, // Call the sign-in method
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the registration screen
                      Navigator.of(context).pushNamed('/sign-up');
                    },
                    child: Column(
                      children: [
                        Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors .blue[900],
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 57,
                          margin: const EdgeInsets.only(top: 5),
                          color: Colors.indigo[900],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}