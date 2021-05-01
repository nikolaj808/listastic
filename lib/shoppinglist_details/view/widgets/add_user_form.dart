import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shoppinglist_details/cubit/shoppinglist_details_cubit.dart';
import 'package:listastic/shoppinglist_details/validators/add_user_form_validator.dart';

class AddUserForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseShoppinglist shoppinglist;

  // ignore: sort_constructors_first
  const AddUserForm({
    Key? key,
    required this.shoppinglist,
  }) : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  late TextEditingController userController;

  @override
  void initState() {
    userController = TextEditingController(text: '');
    super.initState();
  }

  Future<void> _addUserToShoppinglist(BuildContext context) async {
    final currentFormState = AddUserForm._formKey.currentState;

    if (currentFormState == null) {
      return;
    }

    if (!currentFormState.validate()) {
      return;
    }

    await BlocProvider.of<ShoppinglistDetailsCubit>(context)
        .addUserToShoppinglist(
      shoppinglist: widget.shoppinglist,
      email: userController.text,
    );

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
          key: AddUserForm._formKey,
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
                  'Tilføj ny bruger',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextFormField(
                  controller: userController,
                  onFieldSubmitted: (_) => _addUserToShoppinglist(context),
                  validator: AddUserFormValidator.validateNewUserEmail,
                  autofocus: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    labelText: 'Bruger email',
                  ),
                ),
                const Spacer(),
                BlocBuilder<ShoppinglistDetailsCubit,
                    ShoppinglistDetailsCubitState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      elevation: 0,
                      onPressed: () => _addUserToShoppinglist(context),
                      child: state is ShoppinglistDetailsAddingUser
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
