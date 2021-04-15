import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/shoppinglists/repository/firebase_shoppinglists_repository.dart';
import 'package:pedantic/pedantic.dart';

part 'firebase_shoppinglists_cubit_state.dart';

class FirebaseShoppinglistsCubit
    extends Cubit<FirebaseShoppinglistsCubitState> {
  final FirebaseShoppinglistsRepository shoppinglistsRepository;

  // ignore: sort_constructors_first
  FirebaseShoppinglistsCubit({required this.shoppinglistsRepository})
      : super(ShoppinglistsInitial());

  Future<void> getShoppinglistById(String shoppinglistId) async {
    unawaited(shoppinglistsRepository.getShoppinglist(shoppinglistId));
  }
}
