import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/repository/sqflite_items_repository.dart';
import 'package:listastic/models/item/sqflite_item.dart';

part 'sqflite_items_event.dart';
part 'sqflite_items_state.dart';

class SqfliteItemsBloc extends Bloc<SqfliteItemsEvent, SqfliteItemsState> {
  final SqfliteItemsRepository itemsRepository;

  SqfliteItemsBloc({required this.itemsRepository})
      : super(SqfliteItemsInitial());

  @override
  Stream<SqfliteItemsState> mapEventToState(
    SqfliteItemsEvent event,
  ) async* {
    if (event is SqfliteLoadItems) {
      yield* _mapLoadItemsToState(event);
    } else if (event is SqfliteCreateItem) {
      yield* _mapCreateItemToState(event);
    } else if (event is SqfliteUpdateItem) {
      yield* _mapUpdateItemToState(event);
    } else if (event is SqfliteDeleteItem) {
      yield* _mapDeleteItemToState(event);
    } else if (event is SqfliteItemsUpdated) {
      yield* _mapItemsUpdatedToState(event);
    }
  }

  Stream<SqfliteItemsState> _mapLoadItemsToState(
      SqfliteLoadItems event) async* {
    yield SqfliteItemsLoading();

    try {
      final items = await itemsRepository.getItems(event.shoppinglistId);

      add(SqfliteItemsUpdated(items: items));
    } catch (e) {
      yield SqfliteItemsError(message: e.toString());
    }
  }

  Stream<SqfliteItemsState> _mapCreateItemToState(
      SqfliteCreateItem event) async* {
    try {
      final newItem = await itemsRepository.createItem(event.item);

      final currentState = state;

      if (currentState is SqfliteItemsLoaded) {
        add(SqfliteItemsUpdated(items: [newItem, ...currentState.items]));
      } else if (currentState is SqfliteItemsEmpty) {
        add(SqfliteItemsUpdated(items: [newItem]));
      }
    } catch (e) {
      yield SqfliteItemsError(message: e.toString());
    }
  }

  Stream<SqfliteItemsState> _mapUpdateItemToState(
      SqfliteUpdateItem event) async* {
    try {
      final updatedItem = await itemsRepository.updateItem(event.item);

      final currentState = state;

      if (currentState is SqfliteItemsLoaded) {
        final currentItems = currentState.items;

        final updateItemIndex =
            currentItems.indexWhere((item) => item.id == updatedItem.id);

        currentItems.removeAt(updateItemIndex);

        currentItems.insert(updateItemIndex, updatedItem);

        add(SqfliteItemsUpdated(items: currentItems));
      }
    } catch (e) {
      yield SqfliteItemsError(message: e.toString());
    }
  }

  Stream<SqfliteItemsState> _mapDeleteItemToState(
      SqfliteDeleteItem event) async* {
    try {
      final deletedItem = await itemsRepository.deleteItem(event.item);

      final currentState = state;

      if (currentState is SqfliteItemsLoaded) {
        final currentItems = currentState.items;

        currentItems.removeWhere((item) => item.id == deletedItem.id);

        add(SqfliteItemsUpdated(items: currentItems));
      }
    } catch (e) {
      yield SqfliteItemsError(message: e.toString());
    }
  }

  Stream<SqfliteItemsState> _mapItemsUpdatedToState(
      SqfliteItemsUpdated event) async* {
    final items = event.items;

    if (items.isEmpty) {
      yield SqfliteItemsEmpty();
    } else {
      yield SqfliteItemsLoaded(items: items);
    }
  }
}
