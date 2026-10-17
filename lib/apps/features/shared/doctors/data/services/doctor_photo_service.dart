import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class DoctorPhotoService {
  DoctorPhotoService({required FirebaseStorage storage}) : _storage = storage;
  final FirebaseStorage _storage;

  Future<String?> pickAndUpload({String? userId}) async {
    var appStrings = t;
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
      requestFullMetadata: false,
    );
    if (image == null) return null;
    final bytes = await image.readAsBytes();
    if (bytes.length > 5 * 1024 * 1024) {
      throw StateError(appStrings.commonUi.photoTooLarge);
    }
    final extension = image.name.split('.').last.toLowerCase();
    final contentType = switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => throw StateError(appStrings.commonUi.invalidPhoto),
    };
    final folder = userId == null ? 'doctor_photos' : 'profile_photos/$userId';
    final ref = _storage.ref(
      '$folder/${DateTime.now().microsecondsSinceEpoch}.$extension',
    );
    await ref.putData(bytes, SettableMetadata(contentType: contentType));
    return ref.getDownloadURL();
  }
}
