import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:komando_app/data/models/data_models.dart';

Future<XFile?> captureImage() async {
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  try {
    pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 600,
      imageQuality: 50,
    );
    return pickedImage;
  } catch (e) {
    return null;
  }
}

Future<String> uploadStudentImage(Student student, File image) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  String url = '';
  String imageName = student.id!;
  Reference ref = storage.ref().child('students').child(imageName);
  UploadTask uploadTask = ref.putFile(image);
  TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  if (snapshot.state == TaskState.success) {
    // Get the download URL
    url = await snapshot.ref.getDownloadURL();
  }
  return url;
}

Future<String> uploadUserImage(User user, File image) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  String url = '';
  String imageName = user.id!;
  Reference ref = storage.ref().child('users').child(imageName);
  UploadTask uploadTask = ref.putFile(image);
  TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  if (snapshot.state == TaskState.success) {
    // Get the download URL
    url = await snapshot.ref.getDownloadURL();
  }
  return url;
}
