part of 'order_bloc.dart';

final class OrderState extends Equatable {
  LatLng? position;
  String? address;
  String? weight_type;
  String? image_path;
  Map<String, bool>? trash_type;
  String? payment_method;

  OrderState(
      {this.position,
      this.address,
      this.weight_type,
      this.image_path,
      this.trash_type,
      this.payment_method});

  OrderState copyWith({
    LatLng? position,
    String? address,
    String? weight_type,
    String? image_path,
    Map<String, bool>? trash_type,
    String? payment_method,
  }) {
    return OrderState(
      position: position ?? this.position,
      address: address ?? this.address,
      weight_type: weight_type ?? this.weight_type,
      image_path: image_path ?? this.image_path,
      trash_type: trash_type ?? this.trash_type,
      payment_method: payment_method ?? this.payment_method,
    );
  }

  @override
  List get props => [
        position,
        address,
        weight_type,
        image_path,
        trash_type,
        payment_method,
      ];
}

final class OrderSuccess extends OrderState {
  final Order order;

  OrderSuccess(this.order);

  @override
  List get props => [order];
}

final class OrderFailed extends OrderState {}

final class OrdersLoaded extends OrderState {
  final List<Order> orders;

  OrdersLoaded(this.orders);

  @override
  List get props => [orders];
}

final class OrderLoading extends OrderState {}

final class OrdersEmpty extends OrderState {}

final class OrderCanceledSuccess extends OrderState {}

final class TrashTypesLoading extends OrderState {}

final class TrashTypesLoaded extends OrderState {
  final List<TrashType> trashTypes;

  TrashTypesLoaded(this.trashTypes);

  @override
  List get props => [trashTypes];
}

final class TrashTypesError extends OrderState {}
