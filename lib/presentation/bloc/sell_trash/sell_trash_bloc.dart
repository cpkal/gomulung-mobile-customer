import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sell_trash_event.dart';
part 'sell_trash_state.dart';

class SellTrashBloc extends Bloc<SellTrashEvent, SellTrashState> {
  SellTrashBloc() : super(SellTrashInitial()) {
    on<FetchTrashTypes>(_onFetchTrashTypes);
  }

  void _onFetchTrashTypes(FetchTrashTypes event, Emitter<SellTrashState> emit) {
    emit(SellTrashLoading());
    // final trashTypes = await _trashTypeRepository.getTrashTypes();
    // emit(SellTrashLoaded(trashTypes));
  }
}
