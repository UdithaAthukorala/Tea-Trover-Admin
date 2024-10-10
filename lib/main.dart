import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyADUo4W_FXhQAl2BB50TJasTIPZafcMct0",
        appId: "1:6460420556:android:30dc491278b777b25aad69",
        messagingSenderId: "6460420556",
        projectId: "teatrove-358f5",
        databaseURL: 'https://teatrove-358f5-default-rtdb.firebaseio.com',
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tea Trover Admins',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Wrapper(),
    );
  }
}