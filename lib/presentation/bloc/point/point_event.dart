part of 'point_bloc.dart';

sealed class PointEvent extends Equatable {
  const PointEvent();

  @override
  List<Object> get props => [];
}

class FetchPoint extends PointEvent {}

class ConvertPoint extends PointEvent {
  final int point;
  final String bank;
  final String atasNama;
  final String noRek;

  ConvertPoint(this.point, this.bank, this.atasNama, this.noRek);

  @override
  List<Object> get props => [point, bank, atasNama, noRek];
}
