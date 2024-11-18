part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PickOrderLocation extends OrderEvent {
  final LatLng position;

  PickOrderLocation({required this.position});

  @override
  List<Object> get props => [position];
}

class SelectWeightType extends OrderEvent {
  final String weightType;

  SelectWeightType(this.weightType);

  @override
  List<Object> get props => [weightType];
}

class TakeOrderPhoto extends OrderEvent {
  final String imagePath;

  TakeOrderPhoto(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class SelectTrashType extends OrderEvent {
  final String trashType;

  SelectTrashType(this.trashType);

  @override
  List<Object> get props => [trashType];
}

class SelectPaymentMethod extends OrderEvent {
  final String paymentMethod;

  SelectPaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];
}

class SubmitOrder extends OrderEvent {}

class FetchOrders extends OrderEvent {}

class UpdateOrderAddress extends OrderEvent {
  final String address;

  UpdateOrderAddress(this.address);

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

class OrderFetchWeightTypes extends OrderEvent {}

class OrderCalculatePrice extends OrderEvent {}
