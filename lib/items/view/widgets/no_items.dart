import 'package:flutter/material.dart';

class NoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_items.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Der er ingen varer..',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Tryk på tilføj knappen for at tilføje nye varer',
          ),
        ],
      ),
    );
  }
}
