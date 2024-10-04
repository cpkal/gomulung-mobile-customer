import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/crew.dart';

part 'crew_event.dart';
part 'crew_state.dart';

class CrewBloc extends Bloc<CrewEvent, CrewState> {
  CrewBloc() : super(CrewInitial()) {
    on<GetCrewInfo>(_onGetCrewInfo);
  }

  void _onGetCrewInfo(GetCrewInfo event, Emitter<CrewState> emit) async {
    emit(CrewLoading());
    //fetch crew info

    await ApiService.fetchData('/crews/${event.crewId}').then((res) {
      print(res.body);
      final resBody = jsonDecode(res.body);
      final crew = Crew.fromJson(resBody['data']['crew']);
      print(resBody['data']['crew']);
      emit(CrewLoaded(crew));
    }).catchError((error) {
      emit(CrewError(error.toString()));
    });
  }
}
