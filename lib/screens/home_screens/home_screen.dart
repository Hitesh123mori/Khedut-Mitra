import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack_24/screens/home_screens/tab_screens/agreeculture_ai.dart';
import 'package:hack_24/screens/home_screens/tab_screens/home_tab_screen.dart';
import 'package:hack_24/screens/home_screens/tab_screens/price_pridiction.dart';
import 'package:hack_24/screens/home_screens/tab_screens/profile.dart';
import 'package:hack_24/screens/home_screens/tab_screens/scan_history.dart';
import 'package:hack_24/screens/utils/color.dart';

import '../../apis/auth_apis/auth_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> children = [
    HomeTabScreen(),
    ScanHistory(),
    PricePrediction(),
    AgreecultureAi(),
    Profile(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.theme['primaryColor'],
        //   onPressed: () {},
        //   child: Icon(
        //     Icons.document_scanner_outlined,
        //     color: AppColors.theme['secondaryColor'],
        //   ),
        // ),

        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Khedut Mitra",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.theme['secondaryColor']),
          ),
          backgroundColor: AppColors.theme['primaryColor'],
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          selectedItemColor: AppColors.theme['primaryColor'],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.price_check_sharp),
              label: 'Prices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_outlined),
              label: 'assistance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),

      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomeTabScreen();
      case 1:
        return  ScanHistory() ;
      case 2:
        return  PricePrediction() ;
      case 3  :
        return AgreecultureAi() ;
      case 4 :
        return Profile() ;
      default:
        return HomeTabScreen();
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
