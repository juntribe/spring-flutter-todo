import 'package:flutter/material.dart';

import 'models/item.dart';
import 'models/item_data.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final ItemsData itemsData;

  const ItemTile({
    Key? key,
    required this.item,
    required this.itemsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.green,
          value: item.done,
          onChanged: (checkbox) {
            itemsData.updateItem(item);
          },
        ),
        title: Text(
          item.title,
          style: TextStyle(
            decoration:
            item.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            itemsData.deleteItem(item);
          },
        ),
      ),
    );
  }
}
