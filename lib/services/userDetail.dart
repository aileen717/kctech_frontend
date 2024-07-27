class Userdetails{
  final String username;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;

  Userdetails({required this.username,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber});

  Map<String, dynamic> toJson() =>{
    'username' : username,
    'email' : email,
    'password' : password,
    'address' : address,
    'phoneNumber' : phoneNumber,

  };
}