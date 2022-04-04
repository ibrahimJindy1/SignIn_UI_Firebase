import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_social_network/provider/locale_provider.dart';

class Statics {
  static User? user;
  static LocaleProvider? provider;
  static GoogleSignInAccount? account;
}
