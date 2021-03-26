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
    emit(ItemsMutating());

    try {
      await itemsRepository.createItem(item);
      emit(ItemsSuccess());
    } catch (e) {
      emit(ItemsError(message: e.toString()));
      emit(ItemsIdle());
    }
  }
}
