import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hack_24/apis/var_setup.dart';
import '../../main.dart';
import '../home_screens/home_screen.dart';
import '../utils/color.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent));
      if (FirebaseAPIs.auth != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.theme['secondaryColor'],
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 250,
                width: 250,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Khedut Mitra",
                style: TextStyle(
                    color: AppColors.theme['primaryColor'],
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
