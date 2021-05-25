import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/users/repository/users_repository.dart';

class GoogleSigninRepository {
  final UsersRepository usersRepository;

  const GoogleSigninRepository({required this.usersRepository});

  Future<User> login() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;

    if (user == null) {
      throw Exception('No user was found with that credential');
    }

    final listasticUser = ListasticUser.fromUser(user);

    await usersRepository.createUser(listasticUser);

    return user;
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
