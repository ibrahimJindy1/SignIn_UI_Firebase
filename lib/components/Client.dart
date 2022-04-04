class Client {
  final String uid;
  final String firstName;
  final String lastName;
  final String birthdate;
  final String phone;
  final int gender;

  Client(this.uid, this.firstName, this.lastName, this.birthdate, this.phone,
      this.gender);

  Map<String, dynamic> toJson() => {
        'FirstName': firstName,
        'LastName': lastName,
        'Birthdate': birthdate,
        'Phone': phone,
        'Gender': gender,
      };
}
