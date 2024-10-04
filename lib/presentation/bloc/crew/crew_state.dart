part of 'crew_bloc.dart';

sealed class CrewState extends Equatable {
  const CrewState();

  @override
  List<Object> get props => [];
}

final class CrewInitial extends CrewState {}

final class CrewLoading extends CrewState {}

final class CrewLoaded extends CrewState {
  final Crew crew;

  CrewLoaded(this.crew);

  @override
  List<Object> get props => [crew];
}

final class CrewError extends CrewState {
  final String message;

  CrewError(this.message);

  @override
  List<Object> get props => [message];
}
