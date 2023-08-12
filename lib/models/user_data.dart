class UserData {
  String? email;
  String? password;
  bool? adminStatus = false;
  String? id;

  UserData({this.email, this.password, this.adminStatus, this.id});

  // does not pull the users password
  factory UserData.fromFirestore(Map post, String id) {
    return UserData(
      email: post['email'],
      adminStatus: post['admin'],
      id: id
    );
  }
}
