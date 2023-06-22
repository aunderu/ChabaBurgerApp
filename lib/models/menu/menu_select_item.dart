class MenuSelectItem {
  MenuSelectItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  final int id;
  final String name;
  final int price;
  int quantity;

  @override
  String toString() {
    return '{id: $id ,name: $name, price: $price, quantity: $quantity}';
  }
}
