import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, exit the function
    }

    final username = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Check if the username already exists
      final existingUser  = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (existingUser .docs.isNotEmpty) {
        // Show error message if username already exists
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username sudah ada woy...')),
        );
        return;
      }

      // Create a new user document
      await FirebaseFirestore.instance.collection('users').add({
        'username': username,
        'password': password, // Note: Storing passwords in plain text is not secure!
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil Mendaftar Akun !')),
      );

      // Navigate to the sign-in screen after successful registration
      Navigator.of(context).pushNamed('/sign-in');
    } catch (e) {
      // Handle any errors that occur during sign-up
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kesalahan: $e')),
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
                'Pendaftaran PerpusKu !',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.indigo[900]),
              ),
              Form(
                key: _formKey, // Assign the form key
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Masukkan Username !',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan Password !',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: _signUp, // Call the sign-up method
                    child: Column(
                      children: [
                        Text(
                          'Daftar',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.indigo[900]),
                        ),
                        Container(
                          height: 1,
                          width: 57,
                          color: Colors.indigo[900],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the sign-in screen
                      Navigator.of(context).pushNamed('/sign-in');
                    },
                    child: Column(
                      children: [
                        Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[900],
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