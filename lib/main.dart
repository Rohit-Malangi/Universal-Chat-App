import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import '../screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        highlightColor: Colors.deepOrange.shade100,
        backgroundColor: Colors.lightGreenAccent,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepOrange.shade100,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.idTokenChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
