part of 'sell_trash_bloc.dart';

sealed class SellTrashEvent extends Equatable {
  const SellTrashEvent();

  @override
  List<Object> get props => [];
}

class FetchTrashTypes extends SellTrashEvent {}

class UpdateQty extends SellTrashEvent {
  final Trash trash;
  final int qty;

  const UpdateQty(this.trash, this.qty);

  @override
  List<Object> get props => [trash, qty];
}
