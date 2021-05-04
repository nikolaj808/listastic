import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/repository/sqflite_items_repository.dart';
import 'package:listastic/models/item/sqflite_item.dart';

part 'sqflite_items_cubit_state.dart';

class SqfliteItemsCubit extends Cubit<SqfliteItemsCubitState> {
  final SqfliteItemsRepository itemsRepository;

  SqfliteItemsCubit({required this.itemsRepository})
      : super(SqfliteItemsIdle());

  Future<SqfliteItem?> createItem(SqfliteItem item) async {
    emit(SqfliteItemCreating());

    try {
      final createdItem = await itemsRepository.createItem(item);
      emit(SqfliteItemCreateSuccess(item: createdItem));
      return createdItem;
    } catch (e) {
      emit(SqfliteItemError(message: e.toString()));
    } finally {
      emit(SqfliteItemsIdle());
    }
  }

  Future<SqfliteItem?> updateItem(SqfliteItem item) async {
    emit(SqfliteItemUpdating());

    try {
      final updatedItem = await itemsRepository.updateItem(item);
      emit(SqfliteItemUpdateSuccess());
      return updatedItem;
    } catch (e) {
      emit(SqfliteItemError(message: e.toString()));
    } finally {
      emit(SqfliteItemsIdle());
    }
  }

  Future<SqfliteItem?> deleteItem(SqfliteItem item) async {
    emit(SqfliteItemDeleting());

    try {
      final deletedItem = itemsRepository.deleteItem(item);
      emit(SqfliteItemDeleteSuccess());
      return deletedItem;
    } catch (e) {
      emit(SqfliteItemError(message: e.toString()));
    } finally {
      emit(SqfliteItemsIdle());
    }
  }
}
