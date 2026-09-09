import 'package:doctor_hunt/generated/assets.dart';

import '../models/doctor_model.dart';

abstract final class DoctorsService {
  static const List<DoctorModel> doctors = [
    DoctorModel(
      id: '1',
      name: 'Dr. Shruti Kedala',
      specialization: 'Tooths Dentist',
      imagePath: AppAssets.imagesDoctorsDoctorShrutiJpg,
      rating: 4.8,
      experience: 7,
      patientStories: 87,
      price: 28,
      isAvailable: true,
    ),
    DoctorModel(
      id: '2',
      name: 'Dr. Watamanuk',
      specialization: 'Tooths Dentist',
      imagePath: AppAssets.imagesDoctorsDoctorWatamanukJpg,
      rating: 4.7,
      experience: 9,
      patientStories: 74,
      price: 30,
      isAvailable: true,
      isFavorite: true,
    ),
    DoctorModel(
      id: '3',
      name: 'Dr. Crownower',
      specialization: 'Specialist Cardiologist',
      imagePath: AppAssets.imagesDoctorsDoctorBlessingPng,
      rating: 4.9,
      experience: 8,
      patientStories: 92,
      price: 35,
      isAvailable: true,
      isFeatured: true,
      isFavorite: true,
    ),
    DoctorModel(
      id: '4',
      name: 'Dr. Blessing',
      specialization: 'Dentist Specialist',
      imagePath: AppAssets.imagesDoctorsDoctorWatamanukJpg,
      rating: 4.6,
      experience: 6,
      patientStories: 63,
      price: 25,
      isAvailable: true,
      isPopular: true,
      isFeatured: true,
      isFavorite: true,
    ),
    DoctorModel(
      id: '5',
      name: 'Dr. Fillerup Grab',
      specialization: 'Medicine Specialist',
      imagePath: AppAssets.imagesDoctorsLiveDoctor2Png,
      rating: 4.8,
      experience: 10,
      patientStories: 100,
      price: 32,
      isAvailable: true,
      isPopular: true,
      isFeatured: true,
    ),
  ];

  static DoctorModel? doctorById(String id) {
    for (final doctor in doctors) {
      if (doctor.id == id) return doctor;
    }
    return null;
  }
}
