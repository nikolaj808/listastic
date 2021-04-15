import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/bloc/firebase_items_bloc.dart';
import 'package:listastic/items/view/widgets/firebase_items_list.dart';
import 'package:listastic/items/view/widgets/no_items.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shared/snackbars/common_snackbar.dart';

import '../cubit/firebase_items_cubit.dart';

class FirebaseItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FirebaseItemsCubit, FirebaseItemsCubitState>(
      listener: (context, state) {
        if (state is FirebaseItemCreateSuccess) {
          Navigator.of(context).pop();
        }

        if (state is FirebaseItemError) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            CommonSnackbar.error('Der opstod en fejl'),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<FirebaseItemsBloc, FirebaseItemsState>(
          builder: (context, state) {
            if (state is FirebaseItemsLoaded) {
              final items = state.items;

              return FirebaseItemsList(items: items);
            }

            if (state is FirebaseItemsEmpty) {
              return NoItems();
            }

            return LoadingStateFiller();
          },
        ),
      ),
    );
  }
}
