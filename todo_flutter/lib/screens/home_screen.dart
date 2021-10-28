import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/models/item.dart';
import 'package:todo_flutter/models/item_data.dart';
import 'package:todo_flutter/service/database_services.dart';

import '../item_tile.dart';
import 'add_item_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item>? items;

  getItems() async{
    items= await DatabaseServices.getItems();
    Provider.of<ItemsData>(context,listen: false).items = items!;
  }


  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return items == null
        ? const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo Items (${Provider.of<ItemsData>(context).items.length})',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Consumer<ItemsData>(
          builder: (context, itemsData, child) {
            return ListView.builder(
                itemCount: itemsData.items.length,
                itemBuilder: (context, index) {
                  Item item = itemsData.items[index];
                  return ItemTile(
                    item: item,
                    itemsData: itemsData,
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddItemScreen();
              });
        },
      ),
    );
  }
}
