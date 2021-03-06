import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:listastic/app/app_router.dart';
import 'package:listastic/database/database_service.dart';
import 'package:listastic/items/bloc/firebase_items_bloc.dart';
import 'package:listastic/items/bloc/sqflite_items_bloc.dart';
import 'package:listastic/items/cubit/firebase_items_cubit.dart';
import 'package:listastic/items/cubit/sqflite_items_cubit.dart';
import 'package:listastic/items/repository/firebase_items_repository.dart';
import 'package:listastic/items/repository/sqflite_items_repository.dart';
import 'package:listastic/login/cubit/google_signin_cubit.dart';
import 'package:listastic/login/repository/google_signin_repository.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/shoppinglist_details/bloc/shoppinglist_details_bloc.dart';
import 'package:listastic/shoppinglist_details/cubit/shoppinglist_details_cubit.dart';
import 'package:listastic/shoppinglists/bloc/firebase_shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/bloc/sqflite_shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/cubit/firebase_shoppinglists_cubit.dart';
import 'package:listastic/shoppinglists/cubit/sqflite_shoppinglists_cubit.dart';
import 'package:listastic/shoppinglists/repository/firebase_shoppinglists_repository.dart';
import 'package:listastic/shoppinglists/repository/sqflite_shoppinglists_repository.dart';
import 'package:listastic/users/cubit/users_cubit.dart';
import 'package:listastic/users/repository/users_repository.dart';

class App extends StatelessWidget {
  final String initialRoute;

  App({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UsersCubit(
            usersRepository: UsersRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => GoogleSigninCubit(
            googleSigninRepository: GoogleSigninRepository(
              usersRepository: UsersRepository(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ModeCubit(),
        ),
        BlocProvider(
          create: (_) => SqfliteItemsCubit(
            itemsRepository: SqfliteItemsRepository(
              databaseService: DatabaseService(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SqfliteItemsBloc(
            itemsRepository: SqfliteItemsRepository(
              databaseService: DatabaseService(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => FirebaseItemsBloc(
            itemsRepository: FirebaseItemsRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => FirebaseItemsCubit(
            itemsRepository: FirebaseItemsRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => SqfliteShoppinglistsBloc(
            shoppinglistsRepository: SqfliteShoppinglistsRepository(
              databaseService: DatabaseService(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => SqfliteShoppinglistsCubit(
            shoppinglistsRepository: SqfliteShoppinglistsRepository(
              databaseService: DatabaseService(),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => FirebaseShoppinglistsBloc(
            shoppinglistsRepository: FirebaseShoppinglistsRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => FirebaseShoppinglistsCubit(
            shoppinglistsRepository: FirebaseShoppinglistsRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ShoppinglistDetailsBloc(
            shoppinglistsRepository: FirebaseShoppinglistsRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ShoppinglistDetailsCubit(
            shoppinglistsRepository: FirebaseShoppinglistsRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Listastic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          accentColor: Colors.teal,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
