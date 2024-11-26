part of 'sell_trash_bloc.dart';

sealed class SellTrashEvent extends Equatable {
  const SellTrashEvent();

  @override
  List<Object> get props => [];
}

class FetchTrashTypes extends SellTrashEvent {}

class UpdateQty extends SellTrashEvent {
  final List<Trash> trashes;
  final Trash trash;
  final int qty;

  const UpdateQty(this.trashes, this.trash, this.qty);

  @override
  List<Object> get props => [trashes, trash, qty];
}
