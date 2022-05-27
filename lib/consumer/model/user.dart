class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  int? status;
  String? contact;
  String? account;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.contact,
      this.status,
      this.account});

//data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['secondName'],
        password: map['password'],
        contact: map['contact'],
        status: map['status'],
        account: map['account']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': lastName,
      'password': password,
      'contact': contact,
      'status': status,
      'account': account,
    };
  }
}
