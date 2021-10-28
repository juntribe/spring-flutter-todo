class Item {
  final int id;
  final String title;
  bool done;


  Item({
    required this.id,
    required this.title,
    this.done = false,
  });

  factory Item.fromMap(Map itemMap){
    return Item(
      id: itemMap['id'],
      title: itemMap['title'],
      done: itemMap['done'],
    );
  }

  void toggle() {
    done = !done;
  }
}