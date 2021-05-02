part of 'mode_cubit.dart';

abstract class ModeState extends Equatable {
  const ModeState();

  @override
  List<Object> get props => [];
}

class ModeError extends ModeState {}

class ModeOffline extends ModeState {
  final int id;

  const ModeOffline({required this.id});

  @override
  List<Object> get props => [id];
}

class ModeOnline extends ModeState {
  final String id;

  const ModeOnline({required this.id});

  @override
  List<Object> get props => [id];
}
