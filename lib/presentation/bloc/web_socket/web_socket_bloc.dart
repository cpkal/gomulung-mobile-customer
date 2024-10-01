import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'web_socket_event.dart';
part 'web_socket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  final List<WebSocketClient> _clients = [];
  int _nextClientId = 0;

  WebSocketBloc() : super(WebSocketInitial()) {
    on<ConnectWebSocketClient>(_onConnectWebSocketClient);
    on<SendWebSocketMessage>(_onSendWebSocketMessage);
    on<CloseWebSocketClient>(_onCloseWebSocketClient);
  }

  void _onConnectWebSocketClient(
      ConnectWebSocketClient event, Emitter<WebSocketState> emit) {
    final channel = WebSocketChannel.connect(Uri.parse(event.url));
    final client = WebSocketClient(_nextClientId++, channel);
    _clients.add(client);
    emit(WebSocketConnectionsUpdated(List.of(_clients)));

    //return cliend id of the current connected client
    emit(WebSocketClientConnected(client.id));

    print("Connected to ${event.url}");

    //print list of clients
    _clients.forEach((client) {
      print("Client ID: ${client.id}");
    });

    channel.stream.listen((message) {
      emit(WebSocketMessageReceived(client.id, message));
    }, onDone: () {
      _clients.remove(client);
      emit(WebSocketConnectionsUpdated(List.of(_clients)));
    });
  }

  void _onSendWebSocketMessage(
      SendWebSocketMessage event, Emitter<WebSocketState> emit) {
    final client = _clients.firstWhere((client) => client.id == event.clientId);
    client.channel.sink.add(event.message);
  }

  void _onCloseWebSocketClient(
      CloseWebSocketClient event, Emitter<WebSocketState> emit) {
    final client = _clients.firstWhere((client) => client.id == event.clientId);
    client.channel.sink.close();
    _clients.remove(client);
  }
}
