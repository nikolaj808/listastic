import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 96.0),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(index.toString()),
              onDismissed: (_) {},
              background: Container(color: Colors.red),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Text(
                    'x999',
                  ),
                ),
                title: Text('Item number ${index + 1}'),
                subtitle: const Text('Tilføjet af: Nikolaj'),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(Jiffy(DateTime.now()).format('dd/MM/yy')),
                    Text(Jiffy(DateTime.now()).Hm),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
