import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:las_customer/data/datasource/remote/web_socket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final WebSocketService webSocketService;

  WebsocketBloc(this.webSocketService) : super(WebsocketInitial()) {
    on<WebsocketConnect>(_onWebSocketConnect);
    on<WebsocketDisconnect>(_onWebSocketDisconnect);
    on<WebsocketSend>(_onWebSocketSend);
    on<WebsocketReceive>(_onWebSocketReceive);
  }

  void _onWebSocketConnect(
      WebsocketConnect event, Emitter<WebsocketState> emit) {
    webSocketService.connect();
    print('connecting to ws');
    emit(WebsocketConnected('Connected to Websocket'));
  }

  void _onWebSocketSend(WebsocketSend event, Emitter<WebsocketState> emit) {
    webSocketService.send(event.message);
    emit(WebsocketSent(event.message));
  }

  void _onWebSocketReceive(
      WebsocketReceive event, Emitter<WebsocketState> emit) {
    webSocketService.onMessage((message) {
      emit(WebsocketReceived(message));
    });
  }

  void _onWebSocketDisconnect(
      WebsocketDisconnect event, Emitter<WebsocketState> emit) {
    webSocketService.disconnect();
    emit(WebsocketDisconnected());
  }
}
