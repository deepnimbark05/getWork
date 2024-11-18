class UserModel {
  String nickName;
  String dob;
  String phoneNumber;
  String email;
  String gender;
  String about;
  String std;
  int experienceYear;
  int chargesMin;
  int chargesMax;
  String jobType;

  UserModel({
    required this.nickName,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.about,
    required this.std,
    required this.experienceYear,
    required this.chargesMin,
    required this.chargesMax,
    required this.jobType,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'about': about,
      'std': std,
      'experienceYear': experienceYear,
      'chargesMin': chargesMin,
      'chargesMax': chargesMax,
      'jobType': jobType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nickName: map['nickName'] ?? '',
      dob: map['dob'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      about: map['about'] ?? '',
      std: map['std'] ?? '',
      experienceYear: map['experienceYear'] ?? 0,
      chargesMin: map['chargesMin'] ?? 0,
      chargesMax: map['chargesMax'] ?? 0,
      jobType: map['jobType'] ?? '',
    );
  }
}
