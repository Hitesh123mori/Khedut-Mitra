import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hack_24/apis/var_setup.dart';
import 'package:hack_24/screens/models/app_user.dart';
import 'package:hack_24/screens/utils/helper_functions/helper_function,dart.dart';

class AppFirebaseAuth {

  static Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAPIs.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      HelperFunction.showToast("Error: ${e.message}");
    } catch (e) {
      HelperFunction.showToast("An error occurred. Please try again later.");
    }

  }

  static Future<void> signUp(
      BuildContext context, String email, String password, String name, String state, String city) async {
    try {
      UserCredential userCredential = await FirebaseAPIs.auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUserEmail(userCredential, email, password, city, state, name);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        HelperFunction.showToast("The email address is already in use.");
      } else {
        HelperFunction.showToast("Error: ${e.message}");
      }
    } catch (e) {
      HelperFunction.showToast("An error occurred. Please try again later.");
    }
  }


  static Future<void> createUserEmail(
      UserCredential userCredential, String email, String password,String city,String state,String name) async {

    print("User id : ${userCredential.user!.uid}");

    // final time = DateTime.now().millisecondsSinceEpoch.toString();

    final appUser = AppUser(
      userId: userCredential.user!.uid,
      name : name,
      email : email,
      city: city,
      state : state,

    );
    return await FirebaseAPIs.firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(appUser.toJson());
  }


}

