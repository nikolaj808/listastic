import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mode_state.dart';

class ModeCubit extends Cubit<ModeState> {
  final int? sqfliteId;
  final String? firebaseId;

  // ignore: sort_constructors_first
  ModeCubit({this.sqfliteId, this.firebaseId})
      : super(sqfliteId == null
            ? firebaseId == null
                ? ModeError()
                : ModeOnline(id: firebaseId)
            : ModeOffline(id: sqfliteId));

  void setMode(ModeState mode) {
    emit(mode);
  }
}
