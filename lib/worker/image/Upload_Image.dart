import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get_work/worker/image/round_button.dart';
import 'package:image_picker/image_picker.dart';

import 'Utils.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('Images');

  Future<void> getImageGallery() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickerFile != null) {
        _image = File(pickerFile.path);
      } else {
        print('No Image selected');
      }
    });
  }

  Future<void> uploadImage() async {
    if (_image == null) {
      Utils().toastMessage('No image selected');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      String id  = DateTime.now().millisecondsSinceEpoch.toString() ;
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('/FolderName/' + id);
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

      await uploadTask;
      final String newUrl = await ref.getDownloadURL();

      databaseReference.child(id).set({
        'id': id,
        'title': newUrl,
      });

      Utils().toastMessage('Upload successful');
    } catch (error) {
      Utils().toastMessage('Upload failed: $error');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Text(
            'Upload Image',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: getImageGallery,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 39),
            RoundButton(
              title: 'Upload',
              loading: loading,
              onTap: uploadImage,
            ),
          ],
        ),
      ),
    );
  }
}
