import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:listastic/models/shoppinglist.dart';
import 'package:listastic/shoppinglists/cubit/shoppinglists_cubit.dart';

class ListShoppinglist extends StatelessWidget {
  final Shoppinglist shoppinglist;

  // ignore: sort_constructors_first
  const ListShoppinglist({
    Key? key,
    required this.shoppinglist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => BlocProvider.of<ShoppinglistsCubit>(context)
          .getShoppinglistById('hzvqQ19Rc46wn5yvgMHZ'),
      title: Text(shoppinglist.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(Jiffy(shoppinglist.lastModifiedAt).format('dd/MM/yy')),
          Text(Jiffy(shoppinglist.lastModifiedAt).Hm),
        ],
      ),
    );
  }
}
