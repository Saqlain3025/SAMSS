class ConsumerOrderModel {
  String? consumerUid;
  String? email;
  String? firstName;
  String? lastName;
  String? status;
  String? contact;
  String? cityAddress;
  String? homeAddress;
  int? tankerQuantity;
  int? tankerPrice;

  ConsumerOrderModel(
      {this.consumerUid,
      this.email,
      this.firstName,
      this.lastName,
      this.contact,
      this.status,
      this.cityAddress,
      this.homeAddress,
      this.tankerQuantity,
      this.tankerPrice});

//data from server
  factory ConsumerOrderModel.fromMap(map) {
    return ConsumerOrderModel(
        consumerUid: map['consumerUid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['secondName'],
        contact: map['contact'],
        status: map['status'],
        cityAddress: map['cityAddress'],
        homeAddress: map['homeAddress'],
        tankerQuantity: map['tankerQuantity'],
        tankerPrice: map['tankerPrice']);
  }

  Map<String, dynamic> toMap() {
    return {
      'consumerUid': consumerUid,
      'email': email,
      'firstName': firstName,
      'secondName': lastName,
      'contact': contact,
      'status': status,
      'cityAddress': cityAddress,
      'homeAddress': homeAddress,
      'tankerQuantity': tankerQuantity,
      'tankerPrice': tankerPrice,
    };
  }
}
