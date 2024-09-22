import 'package:las_customer/model/data/customer.dart';

class CustomerRepository {
  Future<Customer> getCustomerById(int id) async {
    // Get customer from API
    return Customer(
        email: 'email',
        phoneNumber: 'phoneNumber',
        password: 'password',
        serviceType: 'serviceType',
        name: 'name');
  }
}
