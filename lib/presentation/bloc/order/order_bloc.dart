import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
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
  }
}
