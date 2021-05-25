import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/view/firebase_items_view.dart';
import 'package:listastic/items/view/sqflite_items_view.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, ModeState>(
      builder: (context, state) {
        if (state is ModeOnline) {
          return FirebaseItemsView();
        }

        return SqfliteItemsView();
      },
    );
  }
}
