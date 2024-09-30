import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/order.dart';
import 'package:latlong2/latlong.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<Order> orders = [];

  OrderBloc() : super(OrderState()) {
    on<OrderPositionPicked>((event, emit) {
      print('ini dari order ${event.position}');
      emit(state.copyWith(position: event.position));
    });
    on<OrderWeightTypeChanged>((event, emit) {
      emit(state.copyWith(weight_type: event.weightType));
    });

    on<OrderImagePathChanged>((event, emit) {
      emit(state.copyWith(image_path: event.imagePath));
    });

    on<OrderTrashTypeChanged>((event, emit) {
      emit(state.copyWith(trash_type: event.trashType));
    });

    on<OrderPaymentMethodChanged>((event, emit) {
      emit(state.copyWith(payment_method: event.paymentMethod));
    });

    on<OrderSubmitted>(_onOrderSubmitted);
  }

  void _onOrderSubmitted(OrderSubmitted event, Emitter<OrderState> emit) async {
    // print(state);
    //validate data
    // if (state.position == null ||
    //     state.weight_type == null ||
    //     state.image_path == null ||
    //     state.trash_type == null ||
    //     state.payment_method == null) {
    //   print('something is missing');
    //   emit(OrderFailed());
    //   return;
    // }

    await ApiService.postData('/orders', {
      'sub_total': 10000.toString(),
      'grand_total': 10000.toString(),
      'pickup_location': {
        "lat": state.position!.latitude,
        "long": state.position!.longitude
      },
      'address': 'test address',
      'trash_type': 'Rumahan',
      'trash_weight_selection': state.weight_type,
      'trash_photo_path': 'NO IMAGE',
      'payment_method': 'tunai',
    }).then((res) {
      final order = Order.fromJson(jsonDecode(res.body));

      emit(OrderSuccess(order));
    }).catchError((err) => emit(OrderFailed()));
  }
}
