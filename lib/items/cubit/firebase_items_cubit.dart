import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/repository/firebase_items_repository.dart';
import 'package:listastic/models/item/firebase_item.dart';

part 'firebase_items_cubit_state.dart';

class FirebaseItemsCubit extends Cubit<FirebaseItemsCubitState> {
  final FirebaseItemsRepository itemsRepository;

  FirebaseItemsCubit({required this.itemsRepository})
      : super(FirebaseItemsIdle());

  Future<void> createItem(FirebaseItem item) async {
    emit(FirebaseItemCreating());

    try {
      await itemsRepository.createItem(item);
      emit(FirebaseItemCreateSuccess());
    } catch (e) {
      emit(FirebaseItemError(message: e.toString()));
    } finally {
      emit(FirebaseItemsIdle());
    }
  }

  Future<void> updateItem(FirebaseItem item) async {
    emit(FirebaseItemUpdating());

    try {
      await itemsRepository.updateItem(item);
      emit(FirebaseItemUpdateSuccess());
    } catch (e) {
      emit(FirebaseItemError(message: e.toString()));
    } finally {
      emit(FirebaseItemsIdle());
    }
  }

  Future<void> deleteItem(FirebaseItem item) async {
    try {
      return itemsRepository.deleteItem(item);
    } catch (e) {
      emit(FirebaseItemError(message: e.toString()));
      emit(FirebaseItemsIdle());
    }
  }
}
