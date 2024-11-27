import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/data/model/cartItem.dart';
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
    emit(state.copyWith(loading: true));
    // delay 2 seconds
    final res = await ApiService.fetchData('/sells/trash-types');
    final decoded = jsonDecode(res.body) as List;
    final List<CartItem> cartItems =
        decoded.map((e) => CartItem.fromJson(e)).toList();

    if (res.statusCode == 200) {
      emit(state.copyWith(
        cartItems: cartItems,
        totalPrice: 0,
        loading: false,
      ));
    } else {
      emit(SellTrashError('Failed to fetch data'));
    }
  }

  void _onUpdateQty(UpdateQty event, Emitter<SellTrashState> emit) {
    // recalculate totalPrice
    int totalPrice = state.cartItems!.map((e) {
      if (e.trash.id == event.trash.id) {
        return int.parse(event.trash.priceForMember!) * event.qty;
      } else {
        return int.parse(e.trash.priceForMember!) * e.quantity;
      }
    }).reduce((value, element) => value + element);

    emit(state.copyWith(
      cartItems: state.cartItems!
          .map((e) => e.trash.id == event.trash.id
              ? e.copyWith(quantity: event.qty)
              : e)
          .toList(),
      totalPrice: totalPrice,
    ));
  }
}
