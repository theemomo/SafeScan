class AppUserModel {
  final String uid;
  final String name;
  final String email;

  AppUserModel({required this.uid, required this.email, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'uid': uid, 'email': email, 'name': name};
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }
}