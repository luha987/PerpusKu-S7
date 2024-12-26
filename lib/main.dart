import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/models/data_book.dart';
import 'package:tugas_uas/screens/home_screen.dart';
import 'package:tugas_uas/screens/signin_screen.dart';
import 'package:tugas_uas/screens/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookData>(
      create: (context) => BookData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: const SignInScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
        },
      ),
    );
  }
}
