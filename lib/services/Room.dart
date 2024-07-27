
class Room{
  int id;
  String name;
  String pax;
  String description;
  double price;
  String url;

  Room({
    required this.id,
    required this.name,
    required this.pax,
    required this.description,
    required this.price,
    required this.url});

  factory Room.fromJson(Map<String, dynamic> json){
    return Room(
      id: json['id'] as int,
      name: json['name'] as String,
      pax: json['pax'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      url: json['url'] as String,
    );
  }
}