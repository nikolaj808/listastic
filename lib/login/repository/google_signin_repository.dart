import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/users/repository/users_repository.dart';

class GoogleSigninRepository {
  final UsersRepository usersRepository;

  const GoogleSigninRepository({required this.usersRepository});

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

    final listasticUser = ListasticUser.fromUser(user);

    await usersRepository.createUser(listasticUser);

    return user;
  }

  Future<void> logout() async {
    final googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
