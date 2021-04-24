import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/users/repository/users_repository.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepository usersRepository;

  // ignore: sort_constructors_first
  UsersCubit({required this.usersRepository}) : super(UsersInitial());

  Future<ListasticUser> getUserById(String userId) {
    return usersRepository.getUserById(userId);
  }
}
