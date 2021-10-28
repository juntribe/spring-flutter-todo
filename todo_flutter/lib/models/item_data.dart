import 'package:flutter/cupertino.dart';
import 'package:todo_flutter/models/item.dart';
import 'package:todo_flutter/service/database_services.dart';

class ItemsData extends ChangeNotifier{
  List<Item> items = [];

  void addItem(String itemTitle) async {
    Item item = await DatabaseServices.addItem(itemTitle);
    items.add(item);
    notifyListeners();
  }
  void updateItem(Item item) {
    item.toggle();
    DatabaseServices.updateItem(item.id);
    notifyListeners();
  }

  void deleteItem(Item item) {
    items.remove(item);
    DatabaseServices.deleteItem(item.id);
    notifyListeners();
  }

}