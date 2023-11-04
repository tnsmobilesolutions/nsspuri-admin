// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp/Models/userDetailsModel.dart';

class UserAPI {
  //SignIn

  Future<UserDetailsModel?> signIn(String email, String password) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => uid);

      final userDetails = FirebaseFirestore.instance
          .collection('users')
          .where("uid", isEqualTo: userCredential?.user?.uid)
          .get()
          .then(
        (querySnapshot) {
          for (var element in querySnapshot.docs) {
            final userData = element.data();
            final user = UserDetailsModel.fromMap(userData);
            return user;
          }
        },
      );
      return userDetails;
    } catch (e) {
      print(e);
    }
  }

  Future<UserDetailsModel?> getCurrentUserData() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final currentuid = FirebaseAuth.instance.currentUser?.uid;
    final data =
        await usersCollection.where('uid', isEqualTo: currentuid).get().then(
      (querySnapshot) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        final user = UserDetailsModel.fromMap(userData);
        return user;
      },
    );
    return data;
  }

//Logout
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // creat docID
  Future<int> countUsers() async {
    CollectionReference usercollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot myDoc = await usercollection.get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length; // Count of Documents in Collection
  }
}
