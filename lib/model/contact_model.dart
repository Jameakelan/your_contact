class ContactModel {
  final String name;
  final String mobileNo;
  final String email;
  final bool isFavorite;

  ContactModel({
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "mobileNo": mobileNo,
      "email": email,
      "isFavorite": isFavorite
    };
  }

  ContactModel.fromMap(Map<String, dynamic> cMap)
      : name = cMap['name'],
        mobileNo = cMap['mobileNo'],
        email = cMap['email'],
        isFavorite = cMap['isFavorite'];
}
