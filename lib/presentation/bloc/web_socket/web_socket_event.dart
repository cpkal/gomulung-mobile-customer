part of 'web_socket_bloc.dart';

sealed class WebSocketEvent extends Equatable {
  const WebSocketEvent();

  @override
  List<Object> get props => [];
}

class CloseWebSocketClient extends WebSocketEvent {
  final int clientId;
  CloseWebSocketClient(this.clientId);
}

class ConnectWebSocketClient extends WebSocketEvent {
  final String url;
  ConnectWebSocketClient(this.url);
}

class SendWebSocketMessage extends WebSocketEvent {
  final int clientId;
  final String message;
  SendWebSocketMessage(this.clientId, this.message);
}
