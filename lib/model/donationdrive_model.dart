class DonationDrive {
  final String? id;
  final String name;
  final String description;
  final String? org;

  DonationDrive({
    this.id,
    required this.name,
    required this.description,
    this.org,
  });
}