part of 'websocket_bloc.dart';

sealed class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object> get props => [];
}

final class WebsocketConnect extends WebsocketEvent {}

final class WebsocketDisconnect extends WebsocketEvent {}

final class WebsocketSend extends WebsocketEvent {
  final String message;

  WebsocketSend(this.message);

  @override
  List<Object> get props => [message];
}

final class WebsocketReceive extends WebsocketEvent {
  final String message;

  WebsocketReceive(this.message);

  @override
  List<Object> get props => [message];
}
