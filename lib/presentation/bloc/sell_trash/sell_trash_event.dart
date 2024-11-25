part of 'sell_trash_bloc.dart';

sealed class SellTrashEvent extends Equatable {
  const SellTrashEvent();

  @override
  List<Object> get props => [];
}

class FetchTrashTypes extends SellTrashEvent {}
