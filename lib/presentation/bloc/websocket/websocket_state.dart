part of 'websocket_bloc.dart';

sealed class WebsocketState extends Equatable {
  const WebsocketState();
  
  @override
  List<Object> get props => [];
}

final class WebsocketInitial extends WebsocketState {}
