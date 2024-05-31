class Organizations {
  int id;
  String name;
  String description;
  String? image;
  bool? status;
  String type;

  Organizations({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    this.status,
    required this.type
  });
}