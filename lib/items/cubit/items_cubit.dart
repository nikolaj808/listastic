import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/repository/items_repository.dart';
import 'package:listastic/models/item.dart';

part 'items_cubit_state.dart';

class ItemsCubit extends Cubit<ItemsCubitState> {
  final ItemsRepository itemsRepository;

  // ignore: sort_constructors_first
  ItemsCubit({required this.itemsRepository}) : super(ItemsIdle());

  Future<void> createItem(Item item) async {
    emit(ItemCreating());

    try {
      await itemsRepository.createItem(item);
      emit(ItemCreateSuccess());
    } catch (e) {
      emit(ItemsError(message: e.toString()));
    } finally {
      emit(ItemsIdle());
    }
  }

  Future<void> updateItem(Item item) async {
    emit(ItemUpdating());

    try {
      await itemsRepository.updateItem(item);
      emit(ItemUpdateSuccess());
    } catch (e) {
      emit(ItemsError(message: e.toString()));
    } finally {
      emit(ItemsIdle());
    }
  }

  Future<void> deleteItem(Item item) async {
    try {
      return itemsRepository.deleteItem(item);
    } catch (e) {
      emit(ItemsError(message: e.toString()));
      emit(ItemsIdle());
    }
  }
}
