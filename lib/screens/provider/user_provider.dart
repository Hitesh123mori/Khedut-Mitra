import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../apis/var_setup.dart';
import '../models/app_user.dart';

class AppUserProvider extends ChangeNotifier{
  AppUser? user;

  void notify(){
    notifyListeners();
  }

  // Future initUser() async {
  //   String? uid = FirebaseAPIs.user?.uid;
  //   print("#authId: $uid");
  //   if(uid!=null)
  //     // user = AppUser.fromJson(await UserProfile.getUser(uid));
  //   notifyListeners();
  //   print("#initUser complete");
  // }

  Future logOut() async {
    // await FirebaseAPIs.auth.signOut();
    // user = null;
    notifyListeners();
  }

}