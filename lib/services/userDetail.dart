class UserDetail{
  final String name;
  final String address;
  final String contact;

  UserDetail({required this.name,
    required this.address,
    required this.contact});

  Map<String, dynamic> toJson() =>{
    'name' : name,
    'address' : address,
    'contact' : contact,

  };
}