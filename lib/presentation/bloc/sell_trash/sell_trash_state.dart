part of 'sell_trash_bloc.dart';

sealed class SellTrashState extends Equatable {
  const SellTrashState();

  @override
  List<Object> get props => [];
}

final class SellTrashInitial extends SellTrashState {}

final class SellTrashLoading extends SellTrashState {}

final class SellTrashLoaded extends SellTrashState {
  final List<Trash> trashes;

  const SellTrashLoaded(this.trashes);

  @override
  List<Object> get props => [trashes];
}

final class SellTrashError extends SellTrashState {
  final String message;

  const SellTrashError(this.message);

  @override
  List<Object> get props => [message];
}

final class SellTrashSelected extends SellTrashState {
  final List<Trash> trashes;
  final Trash trash;
  final int qty;

  const SellTrashSelected(this.trashes, this.trash, [this.qty = 0]);

  @override
  List<Object> get props => [trashes, trash, qty];
}
