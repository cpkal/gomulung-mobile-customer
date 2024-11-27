import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';

part 'point_event.dart';
part 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  PointBloc() : super(PointInitial()) {
    on<FetchPoint>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await ApiService.fetchData('/points/my-points');
      final decoded = jsonDecode(res.body);

      emit(state.copyWith(point: decoded['data'], isLoading: false));
    });

    on<ConvertPoint>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await ApiService.postData('/points/convert/money', {
        'point': event.point,
        'bank': event.bank,
        'atas_nama': event.atasNama,
        'no_rek': event.noRek,
      });

      final decoded = jsonDecode(res.body);

      if (res.statusCode == 400) {
        emit(state.copyWith(isLoading: false, error: decoded['message']));
        return;
      }

      emit(state.copyWith(point: decoded['data'], isLoading: false));
    });
  }
}
