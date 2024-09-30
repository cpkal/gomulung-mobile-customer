import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String url;
  late WebSocketChannel _channel;

  WebSocketService(this.url);

  void connect() {
    // Connect to the WebSocket server
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void disconnect() {
    // Disconnect from the WebSocket server
    _channel.sink.close();
  }

  void send(String message) {
    // Send a message to the WebSocket server
    _channel.sink.add(message);
  }

  void onMessage(void Function(String) callback) {
    // Listen for messages from the WebSocket server
    _channel.stream.listen((message) {
      callback(message);
    });
  }
}
