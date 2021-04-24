import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:listastic/items/cubit/firebase_items_cubit.dart';
import 'package:listastic/items/view/widgets/fade_in_added_by.dart';
import 'package:listastic/models/item/firebase_item.dart';

class FirebaseListItem extends StatelessWidget {
  final FirebaseItem item;

  // ignore: sort_constructors_first
  const FirebaseListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id!),
      background: Container(color: Theme.of(context).errorColor),
      onDismissed: (_) {
        context.read<FirebaseItemsCubit>().deleteItem(item);
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text('x${item.quantity}'),
        ),
        title: Text(item.name),
        subtitle: FadeInAddedBy(userId: item.userId),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(Jiffy(item.lastModifiedAt).format('dd/MM/yy')),
            Text(Jiffy(item.lastModifiedAt).Hm),
          ],
        ),
      ),
    );
  }
}
