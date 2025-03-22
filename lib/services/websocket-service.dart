import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

class WebsocketService extends ChangeNotifier {
  late IO.Socket _socket;
  bool socketStatus = false;

  WebsocketService() {
    _connect();
  }

  void _connect() {
    // Conexión al servidor WebSocket
    _socket = IO.io(
      'https://socket-1-8xy5.onrender.com',
      IO.OptionBuilder()
          .setTransports(['websocket']) // Usa WebSocket como transporte
          .build(),
    );

    _socket.on('connect', (_) {
      print('Conectado al servidor');
      socketStatus = true;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('Desconectado del servidor');
      socketStatus = false;
      notifyListeners();
    });

    _socket.on('event_name', (data) {
      print('Evento recibido: $data');
    });
  }

  void emit(String event, [dynamic payload]) {
    print('Emitiendo: $event');
    _socket.emit(event, payload);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
