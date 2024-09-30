part of 'websocket_bloc.dart';

sealed class WebsocketState extends Equatable {
  const WebsocketState();

  @override
  List<Object> get props => [];
}

final class WebsocketInitial extends WebsocketState {}

final class WebsocketConnected extends WebsocketState {
  String message;

  WebsocketConnected(this.message);

  @override
  List<Object> get props => [message];
}

final class WebsocketDisconnected extends WebsocketState {}

final class WebsocketSent extends WebsocketState {
  final String message;

  WebsocketSent(this.message);

  @override
  List<Object> get props => [message];
}

final class WebsocketReceived extends WebsocketState {
  final String message;

  WebsocketReceived(this.message);

  @override
  List<Object> get props => [message];
}
