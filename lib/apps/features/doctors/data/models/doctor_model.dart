class DoctorModel {
  const DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imagePath,
    required this.rating,
    required this.experience,
    required this.patientStories,
    required this.price,
    required this.isAvailable,
    this.isPopular = false,
    this.isFeatured = false,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String specialization;
  final String imagePath;
  final double rating;
  final int experience;
  final int patientStories;
  final double price;
  final bool isAvailable;
  final bool isPopular;
  final bool isFeatured;
  final bool isFavorite;
}
