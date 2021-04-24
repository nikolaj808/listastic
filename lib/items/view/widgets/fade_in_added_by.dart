import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/users/cubit/users_cubit.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class FadeInAddedBy extends StatelessWidget {
  final String userId;

  // ignore: sort_constructors_first
  const FadeInAddedBy({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListasticUser>(
        future: BlocProvider.of<UsersCubit>(context).getUserById(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final user = snapshot.data;

          if (user == null) {
            return const Text('Tilføjet af: Kunne ikke finde brugeren..');
          }

          return PlayAnimation<double>(
            tween: (0.0).tweenTo(1.0),
            builder: (context, child, value) {
              return Text('Tilføjet af: ${user.displayName}');
            },
          );
        });
  }
}
