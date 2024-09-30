part of 'order_bloc.dart';

final class OrderState extends Equatable {
  LatLng? position;
  String? weight_type;
  String? image_path;
  Map<String, bool>? trash_type = {
    'Rumahan': false,
    'Logam': false,
    'Kertas': false,
    'Pakaian': false,
    'Kardus': false,
    'Lainnya': false,
  };
  String? payment_method;

  OrderState(
      {this.position,
      this.weight_type,
      this.image_path,
      this.trash_type,
      this.payment_method});

  OrderState copyWith({
    LatLng? position,
    String? weight_type,
    String? image_path,
    Map<String, bool>? trash_type,
    String? payment_method,
  }) {
    return OrderState(
      position: position ?? this.position,
      weight_type: weight_type ?? this.weight_type,
      image_path: image_path ?? this.image_path,
      trash_type: trash_type ?? this.trash_type,
      payment_method: payment_method ?? this.payment_method,
    );
  }

  @override
  List get props => [
        position,
        weight_type,
        image_path,
        trash_type,
        payment_method,
      ];
}

final class OrderSuccess extends OrderState {}

final class OrderFailed extends OrderState {}
