import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/bloc/items_bloc.dart';
import 'package:listastic/items/view/widgets/create_item_form.dart';
import 'package:listastic/items/view/widgets/items_list.dart';
import 'package:listastic/items/view/widgets/no_items.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shared/snackbars/common_snackbar.dart';

import '../cubit/items_cubit.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsCubit, ItemsCubitState>(
      listener: (context, state) {
        if (state is ItemCreateSuccess) {
          Navigator.of(context).pop();
        }

        if (state is ItemsError) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            CommonSnackbar.success('Der opstod en fejl'),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<ItemsBloc, ItemsState>(
          builder: (context, state) {
            if (state is ItemsLoaded) {
              final items = state.items;

              return ItemsList(items: items);
            }

            if (state is ItemsEmpty) {
              return NoItems();
            }

            return LoadingStateFiller();
          },
        ),
      ),
    );
  }
}
