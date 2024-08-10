import 'package:cloud_firestore/cloud_firestore.dart';

import '../var_setup.dart';

class UserProfile {
  static Future<void> updateCurrCrops(String uid, List<String> newCrops) async {
    try {
      DocumentSnapshot userDoc = await FirebaseAPIs.firestore
          .collection('users')
          .doc(uid)
          .get();


      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

      List<String> existingCrops = (data?['currCrops'] as List<dynamic>?)?.cast<String>() ?? [];

      List<String> updatedCrops = List.from(existingCrops)..addAll(newCrops);

      await FirebaseAPIs.firestore
          .collection('users')
          .doc(uid)
          .update({'currCrops': updatedCrops});

    } catch (e) {
      print("Error updating currCrops: $e");
    }
  }
}
