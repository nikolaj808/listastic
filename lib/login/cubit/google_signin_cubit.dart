import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:listastic/login/repository/google_signin_repository.dart';

part 'google_signin_state.dart';

class GoogleSigninCubit extends Cubit<GoogleSigninState> {
  final GoogleSigninRepository googleSigninRepository;

  GoogleSigninCubit({required this.googleSigninRepository})
      : super(GoogleSigninInitial());

  Future<User?> login() async {
    emit(GoogleSigninLoading());
    User? user;

    try {
      user = await googleSigninRepository.login();

      emit(GoogleSigninSuccess());
    } catch (e) {
      emit(GoogleSigninError());
    }

    emit(GoogleSigninInitial());

    return user;
  }

  Future<void> logout() async {
    emit(GoogleSigninLogout());

    await googleSigninRepository.logout();

    emit(GoogleSigninInitial());
  }

  // TODO: Kind of a hacky way to do this
  String getCurrentUsersId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  String getCurrentUsersDisplayName() {
    return FirebaseAuth.instance.currentUser!.displayName!;
  }
}
