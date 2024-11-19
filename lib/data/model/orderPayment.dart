import 'package:las_customer/data/model/order.dart';
import 'package:las_customer/data/model/payment.dart';

class OrderPayment {
  Order? order;
  Payment? payment;

  OrderPayment({this.order, this.payment});

  OrderPayment.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}
