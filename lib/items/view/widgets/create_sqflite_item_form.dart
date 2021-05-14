import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/bloc/sqflite_items_bloc.dart';
import 'package:listastic/items/cubit/sqflite_items_cubit.dart';
import 'package:listastic/items/validators/create_item_form_validator.dart';
import 'package:listastic/models/item/sqflite_item.dart';
import 'package:listastic/shared/constants.dart';
import 'package:listastic/shared_preferences/service/shared_preferences_service.dart';

import '../../cubit/firebase_items_cubit.dart';

class CreateSqfliteItemForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _CreateSqfliteItemFormState createState() => _CreateSqfliteItemFormState();
}

class _CreateSqfliteItemFormState extends State<CreateSqfliteItemForm> {
  late TextEditingController itemNameController;
  late TextEditingController quantityController;

  @override
  void initState() {
    itemNameController = TextEditingController(text: '');
    quantityController = TextEditingController(text: '1');

    super.initState();
  }

  void _incrementQuantity() {
    final currentValue = quantityController.text;

    final parsedValue = int.tryParse(currentValue);

    if (parsedValue == null) {
      quantityController.text = Constants.minQuantity.toString();
      return;
    }

    if (parsedValue < Constants.minQuantity - 1) {
      quantityController.text = Constants.minQuantity.toString();
      return;
    }

    if (parsedValue >= Constants.maxQuantity) {
      quantityController.text = Constants.maxQuantity.toString();
      return;
    }

    quantityController.text = (parsedValue + 1).toString();
  }

  void _decrementQuantity() {
    final currentValue = quantityController.text;

    final parsedValue = int.tryParse(currentValue);

    if (parsedValue == null) {
      quantityController.text = Constants.minQuantity.toString();
      return;
    }

    if (parsedValue > Constants.maxQuantity + 1) {
      quantityController.text = Constants.maxQuantity.toString();
      return;
    }

    if (parsedValue <= Constants.minQuantity) {
      quantityController.text = Constants.minQuantity.toString();
      return;
    }

    quantityController.text = (parsedValue - 1).toString();
  }

  Future<int?> _getCurrentShoppinglistId() async {
    final sharedPreferencesService = SharedPreferencesService();

    final shoppinglistId = await sharedPreferencesService.getLatest();

    if (shoppinglistId is int) return shoppinglistId;
  }

  Future<void> _createItem(BuildContext context) async {
    final currentFormState = CreateSqfliteItemForm._formKey.currentState;

    if (currentFormState == null) {
      return;
    }

    if (!currentFormState.validate()) {
      return;
    }

    final shoppinglistId = await _getCurrentShoppinglistId();

    if (shoppinglistId != null) {
      final now = DateTime.now();

      final newItem = SqfliteItem(
        shoppinglistId: shoppinglistId,
        name: itemNameController.text,
        quantity: int.parse(quantityController.text),
        createdAt: now,
        lastModifiedAt: now,
      );

      context.read<SqfliteItemsBloc>().add(SqfliteCreateItem(item: newItem));

      Navigator.of(context).pop();
    }
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
          key: CreateSqfliteItemForm._formKey,
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
                  'Tilføj ny vare',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: itemNameController,
                        onFieldSubmitted: (_) => _createItem(context),
                        validator: CreateItemFormValidator.validateItemName,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Vare navn',
                        ),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: quantityController,
                              onFieldSubmitted: (_) => _createItem(context),
                              validator:
                                  CreateItemFormValidator.validateQuantity,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Antal',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_upward,
                                    size: 28.0,
                                  ),
                                  onPressed: _incrementQuantity,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_downward,
                                    size: 28.0,
                                  ),
                                  onPressed: _decrementQuantity,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                BlocBuilder<FirebaseItemsCubit, FirebaseItemsCubitState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      elevation: 0,
                      onPressed: () => _createItem(context),
                      child: state is SqfliteItemCreating
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
