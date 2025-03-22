import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riccos/services/websocket-service.dart';

class SectionConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WebsocketService>(
      builder: (context, wsService, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.black,
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Server status: ',
                style: TextStyle(color: Colors.white),
              ),
              if (wsService.socketStatus)
                const Text(
                  'Online',
                  style: TextStyle(color: Colors.green),
                ),
              if (!wsService.socketStatus)
                const Text(
                  'Offline',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        );
      },
    );
  }
}
