import 'package:flutter/material.dart';
import '../../apis/var_setup.dart';
import '../models/app_user.dart';

class AppUserProvider extends ChangeNotifier {
  AppUser? _user;

  AppUserProvider() {
    _initializeUser();

  }

  AppUser? get user => _user;

  Future<void> _initializeUser() async {
    String? uid = FirebaseAPIs.auth.currentUser?.uid;

    if (uid != null) {
      final doc = await FirebaseAPIs.firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        _user = AppUser(
          userId: uid,
          name: doc.data()?['name'] ?? 'Unknown Name',
          email: doc.data()?['email'] ?? 'Unknown Email',
          city: doc.data()?['city'] ?? 'Unknown City',
          state: doc.data()?['state'] ?? 'Unknown State',
          currCrops: (doc.data()?['currCrops'] as List<dynamic>?)?.cast<String>() ?? [],
          curDeaseas: doc.data()?['curDeaseas'] ?? 'Unknown Decease',
        );
      } else {
        _user = null;
      }
    } else {
      _user = null;
    }

    notifyListeners();
  }


  void setUser(AppUser? newUser) {
    _user = newUser;
    notifyListeners();
  }

  Future<void> logOut() async {
    await FirebaseAPIs.auth.signOut();
    _user = null;
    notifyListeners();
  }



}
