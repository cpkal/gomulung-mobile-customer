import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/order.dart';
import 'package:las_customer/data/model/trashType.dart';
import 'package:latlong2/latlong.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc()
      : super(OrderState(payment_method: 'TUNAI', weight_type: 'Kecil')) {
    on<OrderPositionPicked>((event, emit) {
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

    on<OrderFetchTrashTypes>(_onOrderFetchTrashTypes);

    on<OrderPaymentMethodChanged>((event, emit) {
      emit(state.copyWith(payment_method: event.paymentMethod));
    });

    on<OrderAddressChanged>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<OrderSubmitted>(_onOrderSubmitted);
    on<FetchOrders>(_onFetchOrders);
    on<OrderCanceled>(_onOrderCanceled);
  }

  void _onOrderSubmitted(OrderSubmitted event, Emitter<OrderState> emit) async {
    await ApiService.postData('/orders', {
      'sub_total': 14.toString(),
      'grand_total': 14.toString(),
      'pickup_location': {
        "lat": state.position!.latitude,
        "long": state.position!.longitude
      },
      'address': state.address,
      'trash_type': 'Rumahan',
      'trash_weight_selection': state.weight_type,
      'trash_photo_path': 'NO IMAGE',
      'payment_method': 'TUNAI',
      'feature_type': 'pickup',
    }).then((res) {
      print('hi');
      var decoded = jsonDecode(res.body);
      final order = Order.fromJson(decoded['order']);
      emit(OrderSuccess(order));
    }).catchError((err) {
      print(err);
      emit(OrderFailed());
    });
  }

  void _onFetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    await ApiService.fetchData('/orders').then((res) {
      final orders = jsonDecode(res.body) as List;

      if (orders.isEmpty) {
        emit(OrdersEmpty());
        return;
      }

      emit(OrdersLoaded(orders.map((order) => Order.fromJson(order)).toList()));
    }).catchError((err) => emit(OrderFailed()));
  }

  void _onOrderCanceled(OrderCanceled event, Emitter<OrderState> emit) async {
    await ApiService.deleteData('/orders/${event.id}').then((res) {
      emit(OrderCanceledSuccess());
    }).catchError((err) => emit(OrderFailed()));
  }

  void _onOrderFetchTrashTypes(
      OrderFetchTrashTypes event, Emitter<OrderState> emit) async {
    emit(TrashTypesLoading());

    final res = await ApiService.fetchData('/trashs/categories');
    final resBody = jsonDecode(res.body);
    final trashTypes = resBody['data'] as List;

    Map<String, bool> trashTypesConv = {};

    trashTypes.forEach((element) {
      trashTypesConv[element['category_name']] = false;
    });

    emit(state.copyWith(trash_type: trashTypesConv));
  }
}
