import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/items/repository/firebase_items_repository.dart';
import 'package:listastic/models/item/firebase_item.dart';
import 'package:listastic/shared/utilities/get_current_firebase_shoppinglist.dart';
import 'package:meta/meta.dart';

part 'firebase_items_event.dart';
part 'firebase_items_state.dart';

class FirebaseItemsBloc extends Bloc<FirebaseItemsEvent, FirebaseItemsState> {
  final FirebaseItemsRepository itemsRepository;
  StreamSubscription? _itemsSubscription;

  // ignore: sort_constructors_first
  FirebaseItemsBloc({required this.itemsRepository})
      : super(FirebaseItemsInitial());

  @override
  Stream<FirebaseItemsState> mapEventToState(
    FirebaseItemsEvent event,
  ) async* {
    if (event is FirebaseLoadItems) {
      yield* _mapLoadItemsToState();
    } else if (event is FirebaseItemsUpdated) {
      yield* _mapItemsUpdatedToState(event);
    }
  }

  Stream<FirebaseItemsState> _mapLoadItemsToState() async* {
    yield FirebaseItemsLoading();

    final shoppinglistId = await getCurrentFirebaseShoppinglist();

    if (shoppinglistId != null) {
      await _itemsSubscription?.cancel();
      _itemsSubscription = itemsRepository
          .getItems(shoppinglistId)
          .listen((items) => add(FirebaseItemsUpdated(items: items)));
    }
  }

  Stream<FirebaseItemsState> _mapItemsUpdatedToState(
      FirebaseItemsUpdated event) async* {
    final items = event.items;

    if (items.isEmpty) {
      yield FirebaseItemsEmpty();
    } else {
      yield FirebaseItemsLoaded(items: items);
    }
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}
