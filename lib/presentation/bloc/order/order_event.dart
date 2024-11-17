part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderPositionPicked extends OrderEvent {
  final LatLng position;

  OrderPositionPicked({required this.position});

  @override
  List<Object> get props => [position];
}

class OrderWeightTypeChanged extends OrderEvent {
  final String weightType;

  OrderWeightTypeChanged(this.weightType);

  @override
  List<Object> get props => [weightType];
}

class OrderImagePathChanged extends OrderEvent {
  final String imagePath;

  OrderImagePathChanged(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class OrderTrashTypeChanged extends OrderEvent {
  final Map<String, bool> trashType;

  OrderTrashTypeChanged(this.trashType);

  @override
  List<Object> get props => [trashType];
}

class OrderPaymentMethodChanged extends OrderEvent {
  final String paymentMethod;

  OrderPaymentMethodChanged(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];
}

class OrderSubmitted extends OrderEvent {}

class FetchOrders extends OrderEvent {}

class OrderAddressChanged extends OrderEvent {
  final String address;

  OrderAddressChanged(this.address);

  @override
  List<Object> get props => [address];
}

class OrderCanceled extends OrderEvent {
  final String id;

  OrderCanceled(this.id);

  @override
  List<Object> get props => [id];
}

class OrderFetchTrashTypes extends OrderEvent {}
