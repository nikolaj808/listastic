import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninRepository {
  Future<User> login() async {
    final auth = FirebaseAuth.instance;

    final googleSignIn = GoogleSignIn();

    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      throw Exception('No Google account was chosen');
    }

    final googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final userCredential = await auth.signInWithCredential(credential);

    final user = userCredential.user;

    if (user == null) {
      throw Exception('No user was found with that credential');
    }

    return user;
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
