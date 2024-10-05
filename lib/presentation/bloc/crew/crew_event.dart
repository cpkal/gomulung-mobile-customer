part of 'crew_bloc.dart';

sealed class CrewEvent extends Equatable {
  const CrewEvent();

  @override
  List<Object> get props => [];
}

class GetCrewInfo extends CrewEvent {
  final String crewId;

  GetCrewInfo(this.crewId);

  @override
  List<Object> get props => [crewId];
}

class CheckIsCrewAssigned extends CrewEvent {
  final String orderId;

  CheckIsCrewAssigned(this.orderId);

  @override
  List<Object> get props => [orderId];
}
