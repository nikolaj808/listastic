import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:listastic/app/app_router.dart';
import 'package:listastic/items/bloc/items_bloc.dart';
import 'package:listastic/items/cubit/items_cubit.dart';
import 'package:listastic/items/repository/firebase_items_repository/firebase_items_repository.dart';
import 'package:listastic/l10n/l10n.dart';
import 'package:listastic/login/cubit/google_signin_cubit.dart';
import 'package:listastic/login/repository/google_signin_repository.dart';
import 'package:listastic/shoppinglists/bloc/shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/cubit/shoppinglists_cubit.dart';
import 'package:listastic/shoppinglists/repository/firebase_shoppinglists_repository/firebase_shoppinglists_repository.dart';
import 'package:listastic/shoppinglists/repository/shoppinglists_repository.dart';

class App extends StatelessWidget {
  final String initialRoute;

  // ignore: sort_constructors_first
  App({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GoogleSigninCubit(
            googleSigninRepository: GoogleSigninRepository(),
          ),
        ),
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
        BlocProvider(
          create: (_) => ShoppinglistsBloc(
            shoppinglistsRepository: FirebaseShoppinglistsRepository(),
          )..add(LoadShoppinglists()),
        ),
        BlocProvider(
          create: (_) => ShoppinglistsCubit(
            shoppinglistsRepository: FirebaseShoppinglistsRepository(),
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
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
