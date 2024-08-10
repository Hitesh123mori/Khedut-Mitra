import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hack_24/screens/auth_screens/login_screen.dart';
import 'package:hack_24/screens/auth_screens/splash_screen.dart';
import 'package:hack_24/screens/provider/user_provider.dart';
import 'package:provider/provider.dart';


late Size mq  ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  // runApp(KhedutMitra()) ;
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context)=>AppUserProvider())], child: KhedutMitra()));
}

class KhedutMitra extends StatefulWidget {
  const KhedutMitra({super.key});

  @override
  State<KhedutMitra> createState() => _KhedutMitraState();
}

class _KhedutMitraState extends State<KhedutMitra> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khedut Mitra',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen()
    );
  }
}

Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDihSahFTYGRLd3jJlG57jv0YcN7RdpKNg",
        appId: "1:1019492400127:web:4c7e285f8573fe5530c5ca",
        messagingSenderId: "1019492400127",
        projectId: "khedutmitra-b0ac2",
      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');

  }
}
