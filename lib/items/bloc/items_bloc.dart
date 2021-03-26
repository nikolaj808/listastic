import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/repository/items_repository.dart';
import 'package:listastic/models/item.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository itemsRepository;
  StreamSubscription? _itemsSubscription;

  // ignore: sort_constructors_first
  ItemsBloc({required this.itemsRepository}) : super(ItemsInitial());

  @override
  Stream<ItemsState> mapEventToState(
    ItemsEvent event,
  ) async* {
    if (event is LoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is ItemsUpdated) {
      yield* _mapItemsUpdatedToState(event);
    } else if (event is CreateItem) {
      yield* _mapCreateItemToState(event);
    } else if (event is UpdateItem) {
      yield* _mapUpdateItemToState(event);
    } else if (event is DeleteItem) {
      yield* _mapDeleteItemToState(event);
    }
  }

  Stream<ItemsState> _mapLoadItemsToState() async* {
    yield ItemsLoading();

    await _itemsSubscription?.cancel();
    _itemsSubscription = itemsRepository.getItems().listen(
          (items) => add(ItemsUpdated(items: items)),
        );
  }

  Stream<ItemsState> _mapItemsUpdatedToState(ItemsUpdated event) async* {
    final items = event.items;

    if (items.isEmpty) {
      yield ItemsEmpty();
    } else {
      yield ItemsLoaded(items: event.items);
    }
  }

  Stream<ItemsState> _mapCreateItemToState(CreateItem event) async* {
    unawaited(itemsRepository.createItem(event.item));
  }

  Stream<ItemsState> _mapUpdateItemToState(UpdateItem event) async* {
    unawaited(itemsRepository.updateItem(event.item));
  }

  Stream<ItemsState> _mapDeleteItemToState(DeleteItem event) async* {
    unawaited(itemsRepository.deleteItem(event.item));
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
