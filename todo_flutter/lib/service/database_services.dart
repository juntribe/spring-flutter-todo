
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_flutter/service/globals.dart';
import 'package:todo_flutter/models/item.dart';

class DatabaseServices{
  static Future<Item> addItem(String title) async{
    Map data = {
      "title":title,
    };
    var body= json.encode(data);
    var url = Uri.parse(baseURL + '/add');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Item item = Item.fromMap(responseMap);

    return item;
  }

  static Future<List<Item>> getItems() async{
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Item> items = [];

    for( Map itemMap in responseList){
      Item item = Item.fromMap(itemMap);
      items.add(item);
    }
    return items;
  }

  static Future<http.Response> updateItem(int id) async {
    var url = Uri.parse(baseURL + '/update/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteItem(int id) async {
    var url = Uri.parse(baseURL + '/delete/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}
