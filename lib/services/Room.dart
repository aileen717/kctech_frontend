class Room{
  int id;
  String name;
  String pax;
  double price;
  String url;

  Room({
    required this.id,
    required this.name,
    required this.pax,
    required this.price,
    required this.url});

  factory Room.fromJson(Map<String, dynamic> json){
    return Room(
      id: json['id'] as int,
      name: json['name'] as String,
      pax: json['pax'] as String,
      price: (json['price'] as num).toDouble(),
      url: json['url'] as String,
    );
  }
}