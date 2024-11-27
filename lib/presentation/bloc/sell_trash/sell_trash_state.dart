part of 'sell_trash_bloc.dart';

final class SellTrashState extends Equatable {
  final List<CartItem>? cartItems;
  final int? totalPrice;
  final bool loading;

  const SellTrashState({
    this.cartItems,
    this.totalPrice,
    this.loading = false,
  });

  // copyWith
  SellTrashState copyWith({
    List<CartItem>? cartItems,
    int? totalPrice,
    bool? loading,
  }) {
    return SellTrashState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<dynamic> get props => [
        cartItems,
        totalPrice,
        loading,
      ];
}

final class SellTrashInitial extends SellTrashState {}

final class SellTrashError extends SellTrashState {
  final String message;

  SellTrashError(this.message);

  @override
  List<dynamic> get props => [message];
}
