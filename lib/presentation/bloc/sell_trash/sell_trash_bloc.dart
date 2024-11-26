import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/trash.dart';

part 'sell_trash_event.dart';
part 'sell_trash_state.dart';

class SellTrashBloc extends Bloc<SellTrashEvent, SellTrashState> {
  SellTrashBloc() : super(SellTrashInitial()) {
    on<FetchTrashTypes>(_onFetchTrashes);
    on<UpdateQty>(_onUpdateQty);
  }

  Future<void> _onFetchTrashes(
      FetchTrashTypes event, Emitter<SellTrashState> emit) async {
    emit(SellTrashLoading());
    final res = await ApiService.fetchData('/sells/trash-types');
    final decoded = jsonDecode(res.body) as List;
    final List<Trash> trashes = decoded.map((e) => Trash.fromJson(e)).toList();

    if (res.statusCode == 200) {
      emit(SellTrashLoaded(trashes));
    } else {
      emit(SellTrashError('Failed to fetch data'));
    }
  }

  void _onUpdateQty(UpdateQty event, Emitter<SellTrashState> emit) {
    print(event.trash.subTrashType);
    print(event.qty);
    emit(SellTrashSelected(event.trashes, event.trash, event.qty));
  }
}
