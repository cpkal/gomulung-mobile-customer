part of 'order_bloc.dart';

final class OrderState extends Equatable {
  LatLng? position;
  String? address;
  List<WeightType>? weight_types_list;
  String? weight_type;
  String? image_path;
  List<TrashType>? trash_types_list;
  String? trash_type;
  String? payment_method;
  bool is_button_enabled;
  int? price_total;

  OrderState({
    this.position,
    this.address,
    this.weight_types_list,
    this.weight_type,
    this.image_path,
    this.trash_types_list,
    this.trash_type,
    this.payment_method,
    this.is_button_enabled = false,
    this.price_total,
  });

  OrderState copyWith({
    LatLng? position,
    String? address,
    List<WeightType>? weight_types_list,
    String? weight_type,
    String? image_path,
    List<TrashType>? trash_types_list,
    String? trash_type,
    String? payment_method,
    bool? is_button_enabled,
    int? price_total,
  }) {
    return OrderState(
      position: position ?? this.position,
      address: address ?? this.address,
      weight_types_list: weight_types_list ?? this.weight_types_list,
      weight_type: weight_type ?? this.weight_type,
      image_path: image_path ?? this.image_path,
      trash_types_list: trash_types_list ?? this.trash_types_list,
      trash_type: trash_type ?? this.trash_type,
      payment_method: payment_method ?? this.payment_method,
      is_button_enabled: is_button_enabled ?? this.is_button_enabled,
      price_total: price_total ?? this.price_total,
    );
  }

  @override
  List get props => [
        position,
        address,
        weight_types_list,
        weight_type,
        image_path,
        trash_types_list,
        trash_type,
        payment_method,
        is_button_enabled,
        price_total
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

final class WeightTypesLoading extends OrderState {}

final class WeightTypesLoaded extends OrderState {
  final List<WeightType> weightTypes;

  WeightTypesLoaded(this.weightTypes);

  @override
  List get props => [weightTypes];
}

final class WeightTypesError extends OrderState {}
