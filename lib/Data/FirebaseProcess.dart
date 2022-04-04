import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_social_network/components/Client.dart';

class FirebaseProcess {
  late FirebaseFirestore _firestore;
  late FirebaseApp _firebaseApp;
  FirebaseInit() {
    InitializeFirebase();
  }

  InitializeFirebase() async {
    _firebaseApp = await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    _firestore.settings = Settings(
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }

  Future<void> setNewClient(Client client) async {
    await FirebaseFirestore.instance
        .collection("Clients")
        .doc(client.uid)
        .set(client.toJson());
  }

  Future<void> _upload(String inputSource) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final picker = ImagePicker();
    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'Admin guy',
              'description': 'Some description...'
            }));

        // Refresh the UI

      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<List<Map<String, dynamic>>> loadImages(String url) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref(url).list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  Future<void> _delete(String ref) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.ref(ref).delete();
    // Rebuild the UI
  }
}
