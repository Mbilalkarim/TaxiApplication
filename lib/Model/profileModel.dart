class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? userType;
  String? emailAddress;
  String? dateOfBirth;
  String? phoneNumber;
  String? address;
  String? zipCode;
  String? city;
  String? imageUrl;
  String? cnicNumber; // New property
  String? cnicFrontUrl; // New property
  String? cnicBackUrl; // New property
  String? licenseNo; // New property
  String? licenseUrl; // New property
  bool? isOwnVehicle;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.userType,
    this.emailAddress,
    this.dateOfBirth,
    this.phoneNumber,
    this.address,
    this.zipCode,
    this.city,
    this.imageUrl,
    this.cnicNumber, // New property
    this.cnicFrontUrl, // New property
    this.cnicBackUrl, // New property
    this.licenseNo, // New property
    this.licenseUrl, // New property
    this.isOwnVehicle,
    // New property
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    userType = map['userType'];
    emailAddress = map['emailAddress'];
    dateOfBirth = map['dateOfBirth'];
    phoneNumber = map['phoneNumber'];
    address = map['address'];
    zipCode = map['zipCode'];
    city = map['city'];
    imageUrl = map['imageUrl'];
    cnicNumber = map['cnicNumber']; // New property
    cnicFrontUrl = map['cnicFrontUrl']; // New property
    cnicBackUrl = map['cnicBackUrl']; // New property
    licenseNo = map['licenseNo']; // New property
    licenseUrl = map['licenseUrl']; // New property
    isOwnVehicle = map['isOwnVehicle']; // New property
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userType = json['userType'];
    emailAddress = json['emailAddress'];
    dateOfBirth = json['dateOfBirth'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    zipCode = json['zipCode'];
    city = json['city'];
    imageUrl = json['imageUrl'];
    cnicNumber = json['cnicNumber']; // New property
    cnicFrontUrl = json['cnicFrontUrl']; // New property
    cnicBackUrl = json['cnicBackUrl']; // New property
    licenseNo = json['licenseNo']; // New property
    licenseUrl = json['licenseUrl']; // New property
    isOwnVehicle = json['isOwnVehicle']; // New property
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userType'] = userType;
    data['emailAddress'] = emailAddress;
    data['dateOfBirth'] = dateOfBirth;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['zipCode'] = zipCode;
    data['city'] = city;
    data['imageUrl'] = imageUrl;
    data['cnicNumber'] = cnicNumber; // New property
    data['cnicFrontUrl'] = cnicFrontUrl; // New property
    data['cnicBackUrl'] = cnicBackUrl; // New property
    data['licenseNo'] = licenseNo; // New property
    data['licenseUrl'] = licenseUrl; // New property
    data['isOwnVehicle'] = isOwnVehicle; // New property
    return data;
  }

  @override
  String toString() {
    return 'UserData{id: $userId, txtFName: $firstName, txtLName: $lastName, txtId: $userType,  txtEmail: $emailAddress, txtDOB: $dateOfBirth, txtPhoneNumb: $phoneNumber, txtAddress: $address, txtZipCode: $zipCode, txtCity: $city, imageUrl: $imageUrl, cnicNumber: $cnicNumber, cnicFrontUrl: $cnicFrontUrl, cnicBackUrl: $cnicBackUrl, licenseNo: $licenseNo, licenseUrl: $licenseUrl, isOwnVehicle: $isOwnVehicle}';
  }
}
