class UserResponse {
  final String id;
  final String lastName;
  final String firstName;
  final String userName;
  final String email;
  final String? phoneNumber;
  final String? adress;

  UserResponse({required this.id, required this.lastName, required this.firstName, 
              required this.userName, required this.email, this.phoneNumber, 
              this.adress});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      adress: json['adress'],
    );
  }  
}