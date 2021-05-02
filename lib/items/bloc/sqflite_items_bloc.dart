import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/cubit/sqflite_items_cubit.dart';
import 'package:listastic/items/repository/sqflite_items_repository.dart';
import 'package:listastic/models/item/sqflite_item.dart';

part 'sqflite_items_event.dart';
part 'sqflite_items_state.dart';

class SqfliteItemsBloc extends Bloc<SqfliteItemsEvent, SqfliteItemsState> {
  final SqfliteItemsRepository itemsRepository;
  final SqfliteItemsCubit sqfliteItemsCubit;
  StreamSubscription? _sqfliteItemsCubitSubscription;

  SqfliteItemsBloc({
    required this.itemsRepository,
    required this.sqfliteItemsCubit,
  }) : super(SqfliteItemsInitial()) {
    sqfliteItemsCubit.stream.listen((cubitState) {
      if (cubitState is SqfliteItemCreateSuccess) {
        final currentState = state as SqfliteItemsLoaded;
        final currentItems = currentState.items;

        add(SqfliteItemsUpdated(items: [cubitState.item, ...currentItems]));
      }
    });
  }

  @override
  Stream<SqfliteItemsState> mapEventToState(
    SqfliteItemsEvent event,
  ) async* {
    if (event is SqfliteLoadItems) {
      yield* _mapLoadItemsToState(event);
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

  Stream<SqfliteItemsState> _mapItemsUpdatedToState(
      SqfliteItemsUpdated event) async* {
    final items = event.items;

    if (items.isEmpty) {
      yield SqfliteItemsEmpty();
    } else {
      yield SqfliteItemsLoaded(items: items);
    }
  }

  @override
  Future<void> close() {
    _sqfliteItemsCubitSubscription?.cancel();
    return super.close();
  }
}
