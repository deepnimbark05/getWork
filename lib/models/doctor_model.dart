import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Doctor {
  RxString nickName;
  RxString selectedJob;
  RxString imageUrl;

  Doctor({
    required String nickName,
    required String selectedJob,
    required String imageUrl,
  })  : nickName = RxString(nickName),
        selectedJob = RxString(selectedJob),
        imageUrl = RxString(imageUrl);

  factory Doctor.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Doctor(
      nickName: data['nickName'] ?? 'No Name',
      selectedJob: data['selectedJob'] ?? 'No Job',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
