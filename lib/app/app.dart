// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:listastic/items/bloc/items_bloc.dart';
import 'package:listastic/items/cubit/items_cubit.dart';
import 'package:listastic/items/repository/firebase_items_repository/firebase_items_repository.dart';
import 'package:listastic/items/view/items_page.dart';
import 'package:listastic/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ItemsBloc(
            itemsRepository: FirebaseItemsRepository(),
          )..add(LoadItems()),
        ),
        BlocProvider(
          create: (_) => ItemsCubit(
            itemsRepository: FirebaseItemsRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          accentColor: Colors.teal,
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: ItemsPage(),
      ),
    );
  }
}
