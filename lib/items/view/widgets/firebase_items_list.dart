import 'package:flutter/material.dart';
import 'package:listastic/items/view/widgets/firebase_list_item.dart';
import 'package:listastic/models/item/firebase_item.dart';

class FirebaseItemsList extends StatelessWidget {
  final List<FirebaseItem> items;

  const FirebaseItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.only(bottom: 64.0),
      itemBuilder: (context, index) {
        final item = items[index];

        return FirebaseListItem(item: item);
      },
    );
  }
}
