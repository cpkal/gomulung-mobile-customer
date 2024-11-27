part of 'point_bloc.dart';

final class PointState extends Equatable {
  final int? point;
  final bool isLoading;
  final String? error;

  const PointState({
    this.point,
    this.isLoading = false,
    this.error,
  });

  PointState copyWith({
    int? point,
    bool? isLoading,
    String? error,
  }) {
    return PointState(
      point: point ?? this.point,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<dynamic> get props => [point, isLoading, error];
}

final class PointInitial extends PointState {}
