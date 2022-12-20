class ContactModel {
  final String name;
  final String mobileNo;
  final String email;
  final int isFavorite;

  ContactModel({
    required this.name,
    required this.mobileNo,
    required this.email,
    this.isFavorite = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "mobile": mobileNo,
      "email": email,
      "favorite": isFavorite
    };
  }

  ContactModel.fromMap(Map<String, dynamic> cMap)
      : name = cMap['name'],
        mobileNo = cMap['mobile'],
        email = cMap['email'],
        isFavorite = cMap['favorite'];
}
