import 'package:flutter/material.dart' ;

import '../../apis/auth_apis/auth_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: ()async{
              await AppFirebaseAuth.signOut(context);
            }, child: Text("SIGN OUT"),
          ),
        ),
      ),
    );
  }
}
