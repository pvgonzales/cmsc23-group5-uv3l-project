class Organizations {
  final int id;
  final String name;
  final String description;
  final String? image;
  final bool? status;
  // ADD MORE IF NECESSARY

  Organizations({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    this.status
  });
}