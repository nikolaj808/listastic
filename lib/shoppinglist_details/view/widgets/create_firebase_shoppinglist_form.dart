import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/login/cubit/google_signin_cubit.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shoppinglist_details/cubit/shoppinglist_details_cubit.dart';
import 'package:listastic/shoppinglist_details/validators/create_firebase_shoppinglist_form_validator.dart';

class CreateFirebaseShoppinglistForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  const CreateFirebaseShoppinglistForm({Key? key}) : super(key: key);

  @override
  _CreateFirebaseShoppinglistFormState createState() =>
      _CreateFirebaseShoppinglistFormState();
}

class _CreateFirebaseShoppinglistFormState
    extends State<CreateFirebaseShoppinglistForm> {
  late TextEditingController shoppinglistNameController;

  @override
  void initState() {
    shoppinglistNameController = TextEditingController(text: '');
    super.initState();
  }

  Future<void> _createFirebaseShoppinglist(BuildContext context) async {
    final currentFormState =
        CreateFirebaseShoppinglistForm._formKey.currentState;

    if (currentFormState == null) {
      return;
    }

    if (!currentFormState.validate()) {
      return;
    }

    final now = DateTime.now();

    final shoppinglist = FirebaseShoppinglist(
      name: shoppinglistNameController.text,
      ownerId: BlocProvider.of<GoogleSigninCubit>(context).getCurrentUsersId(),
      userIds: [],
      createdAt: now,
      lastModifiedAt: now,
    );

    await BlocProvider.of<ShoppinglistDetailsCubit>(context)
        .createShoppinglist(shoppinglist: shoppinglist);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
        height: size.height * 0.3,
        width: size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Form(
          key: CreateFirebaseShoppinglistForm._formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 32.0,
              left: 24.0,
              right: 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Tilføj ny indkøbsliste',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextFormField(
                  controller: shoppinglistNameController,
                  onFieldSubmitted: (_) => _createFirebaseShoppinglist(context),
                  validator: CreateFirebaseShoppinglistFormValidator
                      .validateShoppinglistName,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.shopping_cart),
                    labelText: 'Indkøbsliste navn',
                  ),
                ),
                const Spacer(),
                BlocBuilder<ShoppinglistDetailsCubit,
                    ShoppinglistDetailsCubitState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      elevation: 0,
                      onPressed: () => _createFirebaseShoppinglist(context),
                      child: state is ShoppinglistDetailsCreatingShoppinglist
                          ? CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            )
                          : const Icon(Icons.done),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
