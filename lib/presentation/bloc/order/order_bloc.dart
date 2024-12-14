import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/order.dart';
import 'package:las_customer/data/model/orderPayment.dart';
import 'package:las_customer/data/model/payment.dart';
import 'package:las_customer/data/model/trashType.dart';
import 'package:las_customer/data/model/weightType.dart';
import 'package:latlong2/latlong.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    on<PickOrderLocation>((event, emit) {
      final isButtonEnabled = _shouldEnableButton(
        trashType: state.trash_type,
        weightType: state.weight_type,
        location: event.position,
      );

      emit(state.copyWith(
          position: event.position, is_button_enabled: isButtonEnabled));

      if (isButtonEnabled) {
        add(OrderCalculatePrice());
      }
    });

    on<SelectWeightType>((event, emit) {
      final isButtonEnabled = _shouldEnableButton(
        trashType: state.trash_type,
        weightType: event.weightType,
        location: state.position,
      );

      print(isButtonEnabled);

      emit(state.copyWith(
          weight_type: event.weightType, is_button_enabled: isButtonEnabled));

      if (isButtonEnabled) {
        add(OrderCalculatePrice());
      }
    });

    on<TakeOrderPhoto>((event, emit) {
      emit(state.copyWith(image_path: event.imagePath));
    });

    on<SelectTrashType>((event, emit) {
      final isButtonEnabled = _shouldEnableButton(
        trashType: event.trashType,
        weightType: state.weight_type,
        location: state.position,
      );

      emit(state.copyWith(
          trash_type: event.trashType, is_button_enabled: isButtonEnabled));

      if (isButtonEnabled) {
        add(OrderCalculatePrice());
      }
    });

    on<OrderFetchTrashTypes>(_onOrderFetchTrashTypes);

    on<SelectPaymentMethod>((event, emit) {
      emit(state.copyWith(payment_method: event.paymentMethod));
    });

    on<UpdateOrderAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<SubmitOrder>(_onOrderSubmitted);
    on<FetchFinishedOrders>(_onFetchFinishedOrders);
    on<FetchOrders>(_onFetchOrders);
    on<OrderCanceled>(_onOrderCanceled);
    on<OrderFetchWeightTypes>(_onFetchWeightTypse);
    on<OrderCalculatePrice>(_onOrderCalculatePrice);
  }

  void _onOrderSubmitted(SubmitOrder event, Emitter<OrderState> emit) async {
    await ApiService.postData('/orders', {
      'sub_total': state.price_total.toString(),
      'grand_total': state.price_total.toString(),
      'pickup_location': {
        "lat": state.position!.latitude,
        "long": state.position!.longitude
      },
      'address': state.address,
      'trash_type': state.trash_type,
      'trash_weight_selection': state.weight_type,
      'trash_photo_path': state.image_path ?? 'NO IMAGE',
      'payment_method': 'XENDIT_ALL_PAYMENT',
      'feature_type': 'pickup',
    }).then((res) {
      var decoded = jsonDecode(res.body);
      final order = Order.fromJson(decoded['order']);
      final payment = Payment.fromJson(decoded['payment']);
      emit(OrderSuccess(order, payment));
    }).catchError((err) {
      print(err);
      emit(OrderFailed());
    });
  }

  void _onFetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    await ApiService.fetchData('/orders').then((res) {
      final orders = jsonDecode(res.body) as List;

      if (orders.isEmpty) {
        emit(OrdersEmpty());
        return;
      }

      emit(OrdersLoaded(orders.map((e) => OrderPayment.fromJson(e)).toList()));
    }).catchError((err) {
      emit(OrderFailed());
    });
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

    await Future.delayed(Duration.zero);

    emit(state.copyWith(
        trash_type: trashTypes[0]['category_name'],
        trash_types_list:
            trashTypes.map((e) => TrashType.fromJson(e)).toList()));
  }

  void _onFetchWeightTypse(
    OrderFetchWeightTypes event,
    Emitter<OrderState> emit,
  ) async {
    emit(WeightTypesLoading());

    final res = await ApiService.fetchData('/trashs/weights');
    final resBody = jsonDecode(res.body);
    final weightTypes = resBody['data'] as List;

    emit(state.copyWith(
      weight_type: weightTypes[0]['name'],
      weight_types_list:
          weightTypes.map((e) => WeightType.fromJson(e)).toList(),
    ));
  }

  void _onOrderCalculatePrice(
    OrderCalculatePrice event,
    Emitter<OrderState> emit,
  ) async {
    await ApiService.postData('/orders/calculate/price', {
      'trash_weight_selection': state.weight_type,
      'trash_type': state.trash_type,
    }).then((res) {
      final resBody = jsonDecode(res.body);

      emit(state.copyWith(price_total: resBody['total_price']));
    }).catchError((err) {
      print(err);
      // emit(state.copyWith(price_total: 0, is_button_enabled: false));
    });
  }

  bool _shouldEnableButton(
      {String? trashType, String? weightType, LatLng? location}) {
    print(trashType);
    print(weightType);
    print(location);

    return trashType != '' && weightType != '' && location != null;
  }

  void _onFetchFinishedOrders(
    FetchFinishedOrders event,
    Emitter<OrderState> emit,
  ) async {
    await ApiService.fetchData('/orders/finished/get').then((res) {
      final orders = jsonDecode(res.body) as List;

      if (orders.isEmpty) {
        emit(OrdersEmpty());
        return;
      }

      emit(OrdersLoaded(orders.map((e) => OrderPayment.fromJson(e)).toList()));
    }).catchError((err) {
      emit(OrderFailed());
    });
  }
}
