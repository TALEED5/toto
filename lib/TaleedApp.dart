
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

import 'User.dart';
class TaleedApp {
   static UserModel loggedInUser = UserModel();
   static String? uid ="";

  updateFCMUser({required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var saveUser = FirebaseFirestore.instance.collection('users').doc(id);
    saveUser.update({'fcmToken': prefs.getString('fcmToken')});
  }

  Future<String> getFCMUser({required String id}) async {
    var user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    return "${user.data()!['fcmToken']}";
  }
}