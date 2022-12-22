class ContactModel {
  int? id;
  String name;
  String mobileNo;
  String email;
  int favorite;

  ContactModel({
    this.id,
    required this.name,
    required this.mobileNo,
    required this.email,
    this.favorite = 0,
  });

  ContactModel.fromMap(Map<String, dynamic> cMap)
      : id = cMap['id'],
        name = cMap['name'],
        mobileNo = cMap['mobile'],
        email = cMap['email'],
        favorite = cMap['favorite'];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "mobile": mobileNo,
      "email": email,
      "favorite": favorite
    };
  }

  ContactModel copyWith({int? id, String? name, String? mobileNo, String? email}) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
    );
  }
}
