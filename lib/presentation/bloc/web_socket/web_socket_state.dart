part of 'web_socket_bloc.dart';

class WebSocketClient {
  final int id;
  final WebSocketChannel channel;
  WebSocketClient(this.id, this.channel);
}

sealed class WebSocketState extends Equatable {
  const WebSocketState();

  @override
  List<Object> get props => [];
}

final class WebSocketInitial extends WebSocketState {}

class WebSocketConnectionsUpdated extends WebSocketState {
  final List<WebSocketClient> clients;
  WebSocketConnectionsUpdated(this.clients);
}

class WebSocketMessageReceived extends WebSocketState {
  final int clientId;
  final dynamic message;
  WebSocketMessageReceived(this.clientId, this.message);
}

class WebSocketClientConnected extends WebSocketState {
  final int clientId;
  WebSocketClientConnected(this.clientId);
}
