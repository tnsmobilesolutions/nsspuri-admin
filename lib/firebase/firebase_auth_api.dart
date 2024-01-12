import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthentication {
  Future<String?> signinWithFirebase(String email, String password) async {
    try {
      String? uid;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        uid = value.user?.uid;
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
      return uid;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      if (e.code == 'user-not-found') {
        return "user-not-found"; // Handle user not found error
      } else if (e.code == 'wrong-password') {
        return "wrong-password"; // Handle wrong password error
      } else {
        return e.toString();
        // Handle other FirebaseAuth exceptions
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signupWithpassword(String email, String password) async {
    try {
      String? uid;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => uid = value.user?.uid);
//  return uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return e.code;
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return null;
  }

  void signOut() async {
    try {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
// Remove data for the 'counter' key.
      await prefs.remove('jwtToken');
      print("get jwt token: ${prefs.getString("jwtToken")}");
      await prefs.setString("jwtToken", "");
      print("2 get jwt token :${prefs.getString("jwtToken")}");
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
