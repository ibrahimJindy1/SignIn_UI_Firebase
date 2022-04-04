import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_social_network/Statics/statics.dart';
import 'package:random_social_network/constants/firestore_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final SharedPreferences _pref;

  Future<bool> isLoggedIn() async {
    _pref = await SharedPreferences.getInstance();
    bool isLoggedIn = await _googleSignIn.isSignedIn();
    if (isLoggedIn &&
        _pref.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      await _googleSignIn.signInSilently();
      Statics.account = _googleSignIn.currentUser;
      return true;
    } else {
      return false;
    }
  }

  Future<User?> signInwithGoogle() async {
    try {
      _pref = await SharedPreferences.getInstance();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final res = await _auth.signInWithCredential(credential);
      final User? user = res.user;
      if (res.additionalUserInfo!.isNewUser) {
        print('New User');
        print(user);
        Statics.user = user;
        _pref.setString(FirestoreConstants.id, user!.uid);
        return user;
      } else {
        print('Signed');
        print(user);
        Statics.user = user;
        _pref.setString(FirestoreConstants.id, user!.uid);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
