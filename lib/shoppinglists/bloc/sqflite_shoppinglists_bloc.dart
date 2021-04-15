import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/models/shoppinglist/sqflite_shoppinglist.dart';
import 'package:listastic/shoppinglists/repository/sqflite_shoppinglists_repository.dart';

part 'sqflite_shoppinglists_event.dart';
part 'sqflite_shoppinglists_state.dart';

class SqfliteShoppinglistsBloc
    extends Bloc<SqfliteShoppinglistsEvent, SqfliteShoppinglistsState> {
  final SqfliteShoppinglistsRepository shoppinglistsRepository;

  // ignore: sort_constructors_first
  SqfliteShoppinglistsBloc({required this.shoppinglistsRepository})
      : super(SqfliteShoppinglistsInitial());

  @override
  Stream<SqfliteShoppinglistsState> mapEventToState(
    SqfliteShoppinglistsEvent event,
  ) async* {
    if (event is SqfliteLoadShoppinglists) {
      yield* _mapLoadShoppinglistsToState();
    } else if (event is SqfliteShoppinglistsUpdated) {
      yield* _mapShoppinglistsUpdatedToState(event);
    }
  }

  Stream<SqfliteShoppinglistsState> _mapLoadShoppinglistsToState() async* {
    yield SqfliteShoppinglistsLoading();

    final shoppinglists = await shoppinglistsRepository.getShoppinglists();

    yield SqfliteShoppinglistsLoaded(shoppinglists: shoppinglists);
  }

  Stream<SqfliteShoppinglistsState> _mapShoppinglistsUpdatedToState(
      SqfliteShoppinglistsUpdated event) async* {
    final shoppinglists = event.shoppinglists;

    if (shoppinglists.isEmpty) {
      yield SqfliteShoppinglistsEmpty();
    } else {
      yield SqfliteShoppinglistsLoaded(shoppinglists: shoppinglists);
    }
  }
}
