class UserResponse {
  final String id;

  // AUTH
  final String userName;
  final String email;
  final String? phoneNumber;

  // IDENTITÉ
  final String firstName;
  final String lastName;
  final String? gender;
  final DateTime? birthDate;

  // CONTACT
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;

  // DISPLAY
  final String? pictureUrl;
  final String? displayName;
  final String? bio;

  // SETTINGS
  final String? language;
  final bool isPublicIdentity;
  final bool isPublicContact;
  final bool isPublic;

  // AUDIT
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  // ROLES
  final List<String> roles;

  UserResponse({
    required this.id,
    required this.userName,
    required this.email,
    this.phoneNumber,

    required this.firstName,
    required this.lastName,
    this.gender,
    this.birthDate,

    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,

    this.pictureUrl,
    this.displayName,
    this.bio,

    this.language,
    required this.isPublicIdentity,
    required this.isPublicContact,
    required this.isPublic,

    this.createdAt,
    this.updatedAt,
    required this.isActive,

    required this.roles,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] ?? '',

      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],

      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'],
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : null,

      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],

      pictureUrl: json['pictureUrl'],
      displayName: json['displayName'],
      bio: json['bio'],

      language: json['language'],
      isPublicIdentity: json['isPublicIdentity'] ?? true,
      isPublicContact: json['isPublicContact'] ?? true,
      isPublic: json['isPublic'] ?? true,

      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,

      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,

      isActive: json['isActive'] ?? true,

      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}