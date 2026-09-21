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

  Map<String, dynamic> toMap() => {
        'name': name,
        'specialization': specialization,
        'imagePath': imagePath,
        'rating': rating,
        'experience': experience,
        'patientStories': patientStories,
        'price': price,
        'isAvailable': isAvailable,
        'isPopular': isPopular,
        'isFeatured': isFeatured,
        'isFavorite': isFavorite,
      };

  factory DoctorModel.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return DoctorModel(
      id: id,
      name: map['name'] as String? ?? '',
      specialization: map['specialization'] as String? ?? '',
      imagePath: map['imagePath'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0,
      experience: (map['experience'] as num?)?.toInt() ?? 0,
      patientStories: (map['patientStories'] as num?)?.toInt() ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0,
      isAvailable: map['isAvailable'] as bool? ?? true,
      isPopular: map['isPopular'] as bool? ?? false,
      isFeatured: map['isFeatured'] as bool? ?? false,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialization,
    String? imagePath,
    double? rating,
    int? experience,
    int? patientStories,
    double? price,
    bool? isAvailable,
    bool? isPopular,
    bool? isFeatured,
    bool? isFavorite,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      patientStories: patientStories ?? this.patientStories,
      price: price ?? this.price,
      isAvailable: isAvailable ?? this.isAvailable,
      isPopular: isPopular ?? this.isPopular,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
