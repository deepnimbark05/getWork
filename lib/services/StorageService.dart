import 'dart:typed_data'; // Correct import for Uint8List
import 'dart:io'; // Import for File operations
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Fetch list of image URLs from a specific folder in Firebase Storage
  Future<List<String>> fetchImages(String folderPath) async {
    try {
      // List all files in the specified folder
      final ListResult result = await _storage.ref(folderPath).listAll();

      // Get download URLs for each file
      final List<String> imageUrls = await Future.wait(
        result.items.map((ref) => ref.getDownloadURL()).toList(),
      );

      print('Fetched image URLs: $imageUrls');
      return imageUrls;
    } catch (e) {
      print("Error fetching images from folder '$folderPath': $e");
      return [];
    }
  }

  /// Upload a file (binary data or file path) to Firebase Storage
  Future<String?> uploadFile(String folderPath, String fileName, {File? file, Uint8List? fileData}) async {
    try {
      final ref = _storage.ref('$folderPath/$fileName');

      // Ensure either a file or fileData is provided
      if (file != null) {
        print('Uploading file from path: ${file.path}');
        await ref.putFile(file); // Upload using the file
      } else if (fileData != null) {
        print('Uploading binary data');
        await ref.putData(fileData); // Upload using the binary data
      } else {
        throw Exception('No file or fileData provided for upload.');
      }

      // Return the download URL after upload completes
      final url = await ref.getDownloadURL();
      print('File uploaded successfully. Download URL: $url');
      return url;
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }
}
