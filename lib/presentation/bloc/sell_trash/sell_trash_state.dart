part of 'sell_trash_bloc.dart';

sealed class SellTrashState extends Equatable {
  const SellTrashState();

  @override
  List<Object> get props => [];
}

final class SellTrashInitial extends SellTrashState {}

final class SellTrashLoading extends SellTrashState {}

// final class SellTrashLoaded extends SellTrashState {
//   final List<TrashType> trashTypes;

//   const SellTrashLoaded(this.trashTypes);

//   @override
//   List<Object> get props => [trashTypes];
// }
