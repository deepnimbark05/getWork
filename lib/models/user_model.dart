class UserModel {
  String? nickName;
  String? dob;
  String? phoneNumber;
  String? email;
  String? gender;
  String? jobType;
  String? about;
  int? experienceYear;
  int? chargesMin;
  int? chargesMax;
  String? jobLabel;
  String? profileImageUrl;
  String? name; // General name field (optional for flexibility)

  // Constructor
  UserModel({
    this.nickName,
    this.dob,
    this.phoneNumber,
    this.email,
    this.gender,
    this.jobType,
    this.about,
    this.experienceYear,
    this.chargesMin,
    this.chargesMax,
    this.jobLabel,
    this.profileImageUrl,
    this.name, // Optional general name field
  });

  // Convert a UserModel object into a map (to store in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'jobType': jobType,
      'about': about,
      'experienceYear': experienceYear,
      'chargesMin': chargesMin,
      'chargesMax': chargesMax,
      'jobLabel': jobLabel,
      'profileImageUrl': profileImageUrl,
      'name': name, // Add name to the map
    };
  }

  // Factory constructor to create a UserModel object from a map (from Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nickName: map['nickName'],
      dob: map['dob'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      gender: map['gender'],
      jobType: map['jobType'],
      about: map['about'],
      experienceYear: map['experienceYear'],
      chargesMin: map['chargesMin'],
      chargesMax: map['chargesMax'],
      jobLabel: map['jobLabel'],
      profileImageUrl: map['profileImageUrl'],
      name: map['name'], // Deserialize the name field
    );
  }

  // fromJson method: Convert Firestore document to UserModel instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nickName: json['nickName'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      gender: json['gender'],
      jobType: json['jobType'],
      about: json['about'],
      experienceYear: json['experienceYear'],
      chargesMin: json['chargesMin'],
      chargesMax: json['chargesMax'],
      jobLabel: json['jobLabel'],
      profileImageUrl: json['profileImageUrl'],
      name: json['name'], // Deserialize the name field
    );
  }

  // toJson method: Convert UserModel instance to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'nickName': nickName,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'jobType': jobType,
      'about': about,
      'experienceYear': experienceYear,
      'chargesMin': chargesMin,
      'chargesMax': chargesMax,
      'jobLabel': jobLabel,
      'profileImageUrl': profileImageUrl,
      'name': name, // Add name to the map
    };
  }
}
