import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shoppinglists/repository/firebase_shoppinglists_repository.dart';

part 'firebase_shoppinglists_event.dart';
part 'firebase_shoppinglists_state.dart';

class FirebaseShoppinglistsBloc
    extends Bloc<FirebaseShoppinglistsEvent, FirebaseShoppinglistsState> {
  final FirebaseShoppinglistsRepository shoppinglistsRepository;
  StreamSubscription? _shoppinglistsSubscription;

  // ignore: sort_constructors_first
  FirebaseShoppinglistsBloc({required this.shoppinglistsRepository})
      : super(FirebaseShoppinglistsInitial());

  @override
  Stream<FirebaseShoppinglistsState> mapEventToState(
    FirebaseShoppinglistsEvent event,
  ) async* {
    if (event is FirebaseLoadShoppinglists) {
      yield* _mapLoadShoppinglistsToState();
    } else if (event is FirebaseShoppinglistsUpdated) {
      yield* _mapShoppinglistsUpdatedToState(event);
    }
  }

  Stream<FirebaseShoppinglistsState> _mapLoadShoppinglistsToState() async* {
    yield FirebaseShoppinglistsLoading();

    await _shoppinglistsSubscription?.cancel();
    _shoppinglistsSubscription = shoppinglistsRepository
        .getShoppinglists()
        .listen(
          (shoppinglists) =>
              add(FirebaseShoppinglistsUpdated(shoppinglists: shoppinglists)),
        );
  }

  Stream<FirebaseShoppinglistsState> _mapShoppinglistsUpdatedToState(
      FirebaseShoppinglistsUpdated event) async* {
    final shoppinglists = event.shoppinglists;

    if (shoppinglists.isEmpty) {
      yield FirebaseShoppinglistsEmpty();
    } else {
      yield FirebaseShoppinglistsLoaded(shoppinglists: shoppinglists);
    }
  }

  @override
  Future<void> close() {
    _shoppinglistsSubscription?.cancel();
    return super.close();
  }
}
