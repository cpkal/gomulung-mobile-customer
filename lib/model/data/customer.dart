class Customer {
  String name;
  String email;
  String phoneNumber;
  String password;
  String serviceType;

  Customer(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.serviceType});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      password: json['password'],
      serviceType: json['service_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'service_type': serviceType,
    };
  }

  //empty customer
  static var empty = Customer(
    name: '',
    email: '',
    phoneNumber: '',
    password: '',
    serviceType: '',
  );
}
