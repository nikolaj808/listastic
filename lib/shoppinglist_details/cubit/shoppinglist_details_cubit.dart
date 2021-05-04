import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shoppinglists/repository/firebase_shoppinglists_repository.dart';

part 'shoppinglist_details_state.dart';

class ShoppinglistDetailsCubit extends Cubit<ShoppinglistDetailsCubitState> {
  final FirebaseShoppinglistsRepository shoppinglistsRepository;

  ShoppinglistDetailsCubit({
    required this.shoppinglistsRepository,
  }) : super(ShoppinglistDetailsInitial());

  Future<void> createShoppinglist({
    required FirebaseShoppinglist shoppinglist,
  }) async {
    emit(ShoppinglistDetailsCreatingShoppinglist());

    try {
      await shoppinglistsRepository.createShoppinglist(shoppinglist);
      emit(ShoppinglistDetailsCreateShoppinglistSuccess());
    } catch (e) {
      emit(ShoppinglistDetailsCreateShoppinglistError());
    } finally {
      emit(ShoppinglistDetailsInitial());
    }
  }

  Future<void> addUserToShoppinglist({
    required FirebaseShoppinglist shoppinglist,
    required String email,
  }) async {
    emit(ShoppinglistDetailsAddingUser());

    try {
      await shoppinglistsRepository.addUserToShoppinglist(shoppinglist, email);
      emit(ShoppinglistDetailsUserAddSuccess());
    } catch (e) {
      emit(ShoppinglistDetailsUserAddError(message: e.toString()));
    } finally {
      emit(ShoppinglistDetailsInitial());
    }
  }
}
