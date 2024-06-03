class Organizations {
  String uid;
  String name;
  String email;
  String username;
  String address;
  String contact;
  bool approved;
  String description;
  String image;
  bool status;
  String type;

  Organizations({
    required this.uid,
    required this.username,
    required this.name,
    required this.email,
    required this.address,
    required this.contact,
    required this.approved,
    required this.image,
    required this.description,
    required this.status,
    required this.type
  });
}